class AccountServices::SessionsController < Devise::SessionsController
  respond_to :json

  def new
    render json: CommonHelper.error!('ERR00001', ['GET request']),
           status: :method_not_allowed
  end

  private

  def respond_with(resource, _opts={})
    render json: CommonHelper.error!('MSG00001'), status: :created
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: CommonHelper.error!('MSG00002', %w[Logout]), status: :ok
  end

  def log_out_failure
    render json: CommonHelper.error!('ERR00008', %w[Logout]), status: :unprocessable_entity
  end

end
