class Users::RegistrationsController < Devise::RegistrationsController
  # Note: please check Devise::RegistrationsController to properly implements this.
  prepend_before_action :require_no_authentication, only: [:create]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
        render json: message!('', [], "Created new user with email: #{resource}"), status: :created
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        # respond_with resource, location: after_inactive_sign_up_path_for(resource)
        render json: message!('', [], "Signed up but #{resource.inactive_message}"), status: :created
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      # Override default behavior
      render json: message!('', [], "Registration failed, perhaps email #{resource.email} already exists."),
             status: :accepted
    end
  end
end
