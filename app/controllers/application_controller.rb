class ApplicationController < ActionController::API
  include ActionController::StrongParameters,
          ActionController::MimeResponds,
          AccountServices::Helpers,
          CommonHelper

  respond_to :json

  def get_hello
    render json: CommonHelper.error!('',[],"postii started, env=#{Rails.env}."),
           status: :ok
  end

end
