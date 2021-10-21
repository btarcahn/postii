module RolesManager
  extend ActiveSupport::Concern

  def authenticate_admin!
    authenticate_user!
    unless current_user.is_a? Admin
      throw(:warden, { insufficient_authority: true })
    end
  end

  def authenticate_super_user!
    authenticate_admin!
    unless current_user.is_a? SuperUser
      throw(:warden, { insufficient_authority: true })
    end
  end

end
