class AccountServices::LoginController < ApplicationController
  def new
    render json: { errors: ["GET methods not allowed"] }, status: :method_not_allowed
  end

  def create
    user = User.find_by "lower(email) = ? ", user_params[:email].downcase
    if user.present? && user.authenticate(user_params[:password])
      session[:email] = user.email
      render json: { token: token(user.email), email: user.email }, status: :created
    else
      render json: { errors: ['Invalid login credentials'] }, status: :unprocessable_entity
    end
  end

  def destroy
    session[:email] = nil
    render json: { msg: 'Logout successfully!' }
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
