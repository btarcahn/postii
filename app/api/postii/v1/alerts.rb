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

      desc 'Returns the alert message with the exact id'
      params do
        requires :id, type: String
      end
      get '/:id' do
        alert = ErrMsg.find(params[:id])
        present alert
      end

      desc 'Creates an alert message'
      params do
        requires :code, type: String
        requires :component, type: String
        requires :message, type: String
        optional :reason, type: String
        optional :additional_note, type: String
      end
      post do
        alert = ErrMsg.new(err_code: params[:code], component: params[:component], message: params[:message],
                           reason: params[:reason], additional_note: params[:additional_note])
        if alert.save!
          status 201
          present alert
        else
          status 202
          present message!('ERR00008')
        end
      end

      desc 'Updates a complete alert message'
      params do
        requires :id, type: String
        requires :code, type: String
        requires :message, type: String
        requires :component, type: String
        requires :reason, type: String
        requires :additional_note, type: String
      end
      put '/:id' do
        alert = ErrMsg.find(params[:id])
        alert.update(err_code: params[:code], message: params[:message],
                     component: params[:component], reason: params[:reason], additional_note: params[:additional_note])
        status 201
        present alert
      end

      desc 'Patches an alert message on several attributes'
      params do
        requires :id, type: String
        optional :code, type: String
        optional :message, type: String
        optional :component, type: String
        optional :reason, type: String
        optional :additional_note, type: String
      end
      patch '/:id' do
        alert = ErrMsg.find(params[:id])

        alert.update(err_code: params[:code]) if params[:code].present?
        alert.update(message: params[:message]) if params[:message].present?
        alert.update(component: params[:component]) if params[:component].present?
        alert.update(reason: params[:reason]) if params[:reason].present?
        alert.update(additional_note: params[:additional_note]) if params[:additional_note].present?

        status 201
        present alert
      end

      desc 'Deletes an alert message via id'
      params do
        requires :id, type: String
      end
      delete '/:id' do
        alert = ErrMsg.destroy(params[:id])
        present alert
      end

      desc 'Queries for matching alert messages'
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
