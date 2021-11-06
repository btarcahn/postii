module Postii::V1
  class Profile < Grape::API
    version 'v1', using: :path
    format :json

    helpers Devise::Controllers::Helpers, RolesManager

    before { authenticate_user! }

    resource :profile do
      desc "Return current User's profile"
      get do
        @user = current_user
        @creator = Creator.find(@user.creator_id)
        present @user
      end
    end
  end
end
