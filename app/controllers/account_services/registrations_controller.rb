class AccountServices::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts={})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: CommonHelper.error!('MSG00002', %w[Registration]), status: :ok
  end

  def register_failed
    render json: CommonHelper.error!('ERR00008', %w[Registration]), status: :unprocessable_entity
  end
end
