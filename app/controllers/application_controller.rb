require './lib/PostiiConstants'

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication,
          ActionController::StrongParameters,
          AccountServices::Helpers,
          CommonHelper

  before_action :set_current_user

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    render json: CommonHelper.construct_error_message('ERR00004'),
           status: :unauthorized if Current.user.nil?
  end
end
