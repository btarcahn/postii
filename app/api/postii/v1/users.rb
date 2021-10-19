module Postii::V1
  class Users < Grape::API
    version 'v1', using: :path
    format :json

    helpers Devise::Controllers::Helpers

    before { authenticate_user! }

    resource :users do
      desc 'Return a list of users'
      get do
        users = User.all
        present users
      end

      desc 'Returns a specific user by id'
      params do
        requires :id, type: String
      end
      get ':id' do
        user = User.find(params[:id])
        present user
      end

      desc 'Returns a query result (a WHERE search)'
      params do
        optional :email, type: String, regexp: /^[^\s@]+@[^\s@]+\.[^\s@]+$/
        exactly_one_of :email
      end
      post '/query' do
        if params[:email].present?
          user = User.where(email: params[:email])
          present user
        end
      end
    end
  end
end
