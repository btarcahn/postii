module Postii::V1
  class Alerts < Grape::API
    version 'v1', using: :path
    format :json

    helpers Devise::Controllers::Helpers

    before { authenticate_user! }

    resource :alerts do
      desc 'Returns a list of alert messages'
      get do
        alerts = ErrMsg.all
        present alerts
      end

      desc 'Query for matching alert messages'
      params do
        optional :id, type: String
        optional :code, type: String
        optional :component, type: String
        exactly_one_of :id, :code, :component
      end

      post '/query' do
        if params[:id].present?
          alert = ErrMsg.find(params[:id])
          present alert
        end

        if params[:code].present?
          alert = ErrMsg.find_by_err_code(params[:code])
          present alert
        end

        if params[:component].present?
          alerts = ErrMsg.where(component: params[:component])
          present alerts
        end
      end

    end
  end
end
