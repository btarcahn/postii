class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication,
          ActionController::StrongParameters,
          AccountServices::Helpers,
          CommonHelper

  def get_hello
    render json: CommonHelper.construct_error_message('MSG00001'),
           status: :ok
  end

end
