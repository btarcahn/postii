class AccountServices::RegistrationsController < ApplicationController

  def new
    @user = User.new
    render json: CommonHelper.construct_error_message('ERR00001', ['GET request']),
           status: :method_not_allowed
  end

  def create
    # Check whether there's already an email
    render json: CommonHelper.construct_error_message('ERR00007',
                                                      ["User with email #{user_params[:email]}"]),
           status: :unauthorized and return if User.exists? email: user_params[:email]

    @user = User.new(user_params)
    if @user.save
      session[:email] = @user.email
      render json: {
        "msg": "User with email #{@user.email} created!"
      }, status: :ok
    else
      render json: {
        "msg": "Please try again or contact admin."
      }, status: :internal_server_error
    end
  end

  def exists
      render json: {
        email: email_params[:email],
        exists: User.exists?(email: email_params[:email])
      }
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def email_params
    params.require(:user).permit(:email)
  end
end
