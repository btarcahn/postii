class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication, ActionController::StrongParameters

  before_action :set_current_user

  def root_account_services
    render json: {
      "msg": 'Account services is ready!'
    }
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    render json: {"msg": "You must be signed in!"},
           status: :unauthorized if Current.user.nil?
  end
end
