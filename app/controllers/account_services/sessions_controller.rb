class AccountServices::SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        "msg": "Login successful!"
      }
    else
      render json: CommonHelper.construct_error_message('ERR00006'), status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {"msg": "OK!"}
  end
end
