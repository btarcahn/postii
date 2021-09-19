class AccountServices::RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: {
        "msg": "User #{@user.id} created!"
      }
    else
      render json: {
        "msg": "Please try again or contact admin."
      }, status: :internal_server_error
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
