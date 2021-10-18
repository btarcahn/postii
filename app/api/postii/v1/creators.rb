module Postii::V1
  class Creators < Grape::API
    version 'v1', using: :path
    format :json

    helpers Devise::Controllers::Helpers

    before { authenticate_user! }

    resource :creators do
      desc 'View BasicPosters of a creator'
      params do
        requires :id, type: String
      end
      get '/:id/basic_posters' do
        creator = Creator.find(params[:id])
        basic_posters = creator.basic_posters
        present basic_posters
      end

      desc 'Create a BasicPoster for a creator'
      params do
        requires :id, type: String
        optional :poster_id, type: String
        optional :title, type: String
        optional :description, type: String
        optional :security_question, type: String
        optional :security_answer, type: String
        optional :passcode, type: String
      end
      post '/:id/basic_posters' do
        creator = Creator.find(params[:id])
        basic_poster = creator.basic_posters.create(
          poster_id: params[:poster_id],
          title: params[:title],
          description: params[:description],
          security_question: params[:security_question],
          security_answer: params[:security_answer],
          passcode: params[:passcode]
        )
        present basic_poster
      end

      desc 'Responses to a Creator query (WHERE search)'
      params do
        optional :creator_name, type: String
        optional :email_address, type: String, regexp: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
        optional :sector_code, type: String
        optional :prefix_code, type: String
        exactly_one_of :id, :creator_name, :email_address, :sector_code, :prefix_code
      end

      post '/query' do
        if params[:creator_name].present?
          creators = Creator.where('name LIKE ?', "%#{params[:creator_name]}%")
          present creators
        end

        if params[:email_address].present?
          creator = Creator.find_by_email_address(params[:email_address])
          present creator
        end

        if params[:sector_code].present?
          creators = Creator.where(sector_code: params[:sector_code])
          present creators
        end

        if params[:prefix_code].present?
          creators = Creator.where(prefix_code: params[:prefix_code])
          present creators
        end
      end
    end
  end
end
