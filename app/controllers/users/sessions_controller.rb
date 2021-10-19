class Users::SessionsController < Devise::SessionsController
  include Devise::Controllers::Helpers

  respond_to :json

  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action(only: [:create]) { request.env["devise.skip_timeout"] = true }

  def new
    render json: message!('ERR00006'), status: :unauthorized
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    # Override default behavior and render the message instead
    render json: message!('MSG00001'), status: :created
  end

end
