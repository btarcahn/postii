class AccountServices::PasswordsController < ApplicationController
  before_action :require_user_logged_in!
  def edit; end

  def update
    if Current.user.update(password_params)
      render json: {"msg": "Password updated!"}
    else
      render json: {"msg": "Error: password not updated."}, status: :internal_server_error
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
