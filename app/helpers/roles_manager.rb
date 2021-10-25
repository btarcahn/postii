module RolesManager
  extend ActiveSupport::Concern

  def authenticate_admin!
    authenticate_user!
    unless current_user.is_a? Admin
      throw(:warden, { insufficient_authority: %w[ERR00010 Admin] })
    end
  end

  def authenticate_super_user!
    authenticate_admin!
    unless current_user.is_a? SuperUser
      throw(:warden, { insufficient_authority: %w[ERR00010 SuperUser] })
    end
  end
end
