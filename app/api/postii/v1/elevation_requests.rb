module Postii::V1
  class ElevationRequests < Grape::API
    version 'v1', using: :path
    format :json

    helpers do
      include Devise::Controllers::Helpers, RolesManager, AlertHelpers

      # Performs authentication check: if the Admin's Creator and the ElevationRequest's Creator
      # are the same, the patch is allowed.
      def is_patch_authorized!

        unless current_user.is_a?(SuperUser) || @response.creator_id == current_user.creator_id
          throw(:warden, { insufficient_authority:
                             "Cannot PATCH, not in the same Creator/Organization" })
        end

        unless current_user.is_a?(SuperUser) || @response.status.to_i < params[:status]
          throw(:warden, { insufficient_authority:
                             "You're not allowed to change status backward: from #{@response.status.to_i} to #{params[:status]}. Contact a superuser!" })
        end
      end

      def generate_sql_for_index!
        if current_user.is_a?(SuperUser)
          return ['1=1', {}]
        end

        if current_user.is_a?(Admin)
          return ["(creator_id = :creator_id)", { creator_id: current_user.creator_id }]
        end

        if current_user.is_a?(User)
          return ["( creator_id = :creator_id AND ( target_id = :target_id OR created_by_id = :created_by_id ))",
            { creator_id: current_user.creator_id, target_id: current_user.id, created_by_id: current_user.id }]
        end

        raise ArgumentError "Object #{role} is not of type User, Admin, or SuperUser"
      end

      def has_sufficient_authority?
        return false unless @response.is_a? ElevationRequest

        if current_user.is_a? SuperUser
          return true
        end
        if current_user.is_a? Admin
          return @response.creator_id.eql?(current_user.creator_id)
        end
        if current_user.is_a? User
          return @response.creator_id.eql?(current_user.creator_id) &&
            (@response.created_by_id.eql?(current_user.id) || @response.target_id.eql?(current_user.id))
        end

        false
      end

      def check_sufficient_authority
        if has_sufficient_authority?
          present @response
        else
          throw(:warden, { insufficient_authority:
                             "Your account does not have authority to see this record" })
        end
      end
    end

    before { authenticate_user! }

    resource :elevation_requests do

      desc 'Returns a list of Elevation Requests, based on the role'
      get do
        @response = ElevationRequest.where(generate_sql_for_index!)
        present @response
      end

      desc 'Returns one Elevation Requests by ID'
      params do
        requires :id, type: String
      end
      get '/:id' do
        @response = ElevationRequest.find(params[:id])
        check_sufficient_authority
      end

      desc 'Creates an Elevation Request'
      params do
        optional :target_id, type: Integer
        optional :target_email, type: String
        exactly_one_of :target_id, :target_email
      end
      post '/create' do

        if params[:target_id].present?
          target = User.find(params[:target_id])
        elsif params[:target_email].present?
          target = User.find_by_email!(params[:target_email])
        else
          target = current_user
        end

        if target.is_a? Admin
          status 202
          present message!('', [], 'This user is already elevated')
        elsif ElevationRequest.exists?(
          created_by_id: current_user.id, target: target, creator_id: current_user.creator_id
        )
          status 401
          present message!('ERR00007', ["Elevation Request for #{target.email}"])
        else
          creator = Creator.find(current_user.creator_id)
          @response = ElevationRequest.create!(
            creator: creator, status: :created, created_by: current_user, target: target
          )
          present @response
        end
      end

      desc 'Queries for Elevations Requests that matches an attribute'
      params do
        optional :id, type: Integer
        optional :creator_id, type: Integer
        optional :status, type: Integer
        optional :created_by_id, type: Integer
        optional :target_id, type: Integer
        optional :answered_by_id, type: Integer
        exactly_one_of :id, :creator_id, :status, :created_by_id, :target_id, :answered_by_id
      end
      post '/query' do
        if params[:id].present?
          @response = ElevationRequest.find(params[:id])
          check_sufficient_authority
        end
        if params[:creator_id].present?
          statement, hash = generate_sql_for_index!
          hash[:p_creator_id] = params[:creator_id]
          @response = ElevationRequest.where(["#{statement} AND creator_id = :p_creator_id", hash])
          present @response
        end
        if params[:status].present?
          statement, hash = generate_sql_for_index!
          hash[:p_status] = params[:status]
          @response = ElevationRequest.where(["#{statement} AND status = :p_status", hash])
          present @response
        end
        if params[:created_by_id].present?
          statement, hash = generate_sql_for_index!
          hash[:p_created_by_id] = params[:created_by_id]
          @response = ElevationRequest.where(["#{statement} AND created_by_id = :p_created_by_id", hash])
          present @response
        end
        if params[:target_id].present?
          statement, hash = generate_sql_for_index!
          hash[:p_target_id] = params[:target_id]
          @response = ElevationRequest.where(["#{statement} AND target_id = :p_target_id", hash])
          present @response
        end
        if params[:answered_by_id].present?
          statement, hash = generate_sql_for_index!
          hash[:p_answered_by_id] = params[:answered_by_id]
          @response = ElevationRequest.where(["#{statement} AND answered_by_id = :p_answered_by_id", hash])
          present @response
        end
      end

      desc 'Executes (accept/reject) an Elevation Request'
      params do
        requires :id, type: Integer
        requires :accept, type: Boolean
      end
      post '/execute' do
        authenticate_admin!
        @response = ElevationRequest.find(params[:id])

        if has_sufficient_authority?
          # Executes the Elevation Request
          @response.update!(answered_by: current_user)
          if params[:accept]
            @response.target.update!(role: 'Admin')
            @response.update!(status: :accepted)
            status 201
            present message!('', [], "Elevated #{current_user.email} to Admin")
          else
            @response.update!(status: :rejected)
            status 200
            present message!('', [], "Elevation for #{current_user.email} rejected")
          end
        else
          status 401
          present message!('ERR00010', ['Admin within the Creator/Organization'])
        end
      end

      desc 'Updates attributes for an Elevation Request'
      params do
        requires :id, type: String
        optional :status, type: Integer
        optional :target_id, type: Integer
        optional :answered_by_id, type: Integer
        optional :due_date, type: DateTime
        at_least_one_of :status, :target_id, :answered_by_id, :due_date
      end
      patch '/:id' do
        authenticate_admin!

        @response = ElevationRequest.find(params[:id])

        if params[:status].present?
          is_patch_authorized!
          @response.update(status: params[:status])
        end

        if params[:due_date].present?
          is_patch_authorized!
          @response.update(due_date: params[:due_date])
        end

        if params[:target_id].present?
          authenticate_super_user!
          if User.exists?(id: params[:target_id])
            @response.update(target: User.find(params[:id]))
          else
            @response = message!(
              'ERR00003',
              ["Targeted user with id=#{params[:target_id]}"]
            )
          end
        end

        if params[:answered_by_id].present?
          authenticate_super_user!
          if User.exists?(id: params[:answered_by_id])
            @response.update(answered_by: User.find(params[:id]))
          else
            @response = message!(
              'ERR00003',
              ["Answered by user with id=#{params[:answered_by_id]}"]
            )
          end
        end
        status(@response.is_a?(ElevationRequest) ? 201 : 400)
        present @response
      end

      desc 'Deletes an Elevation Request with an id'
      params do
        requires :id, type: String
      end
      delete '/:id' do
        authenticate_super_user!
        elevation_request = ElevationRequest.find(params[:id])
        ElevationRequest.destroy(params[:id])
        status 201
        present elevation_request
      end
    end
  end
end
