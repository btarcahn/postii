module Postii::V1
  class ElevationRequests < Grape::API
    version 'v1', using: :path
    format :json

    helpers Devise::Controllers::Helpers, RolesManager, AlertHelpers

    before { authenticate_user! }

    resource :elevation_requests do

      desc 'Returns a list of Elevation Requests, based on the role'
      get do
        elevation_requests = ElevationRequest.all
        present elevation_requests
      end

      desc 'Returns one Elevation Requests by ID'
      params do
        requires :id, type: String
      end
      get '/:id' do
        elevation_request = ElevationRequest.find(params[:id])
        present elevation_request
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
          elevation_request = ElevationRequest.find(params[:id])
          present elevation_request
        end
        if params[:creator_id].present?
          elevation_request = ElevationRequest.find_by_creator_id(params[:creator_id])
          present elevation_request
        end
        if params[:status].present?
          elevation_request = ElevationRequest.find_by_status(params[:status])
          present elevation_request
        end
        if params[:created_by_id].present?
          elevation_request = ElevationRequest.find_by_created_by_id(params[:created_by_id])
          present elevation_request
        end
        if params[:target_id].present?
          elevation_request = ElevationRequest.find_by_target_id(params[:target_id])
          present elevation_request
        end
        if params[:answered_by_id].present?
          elevation_request = ElevationRequest.find_by_answered_by_id(params[:answered_by_id])
          present elevation_request
        end
      end

      desc 'Updates attributes for an Elevation Request'
      params do
        requires :id, type: String
        optional :status, type: Integer
        optional :target_id, type: Integer
        optional :answered_by_id, type: Integer
        optional :due_date, type: DateTime
      end
      patch '/:id' do
        authenticate_admin!

        @response = ElevationRequest.find(params[:id])

        @response.update(status: params[:status]) if params[:status].present?
        @response.update(due_date: params[:due_date]) if params[:due_date].present?

        if params[:target_id].present?
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
