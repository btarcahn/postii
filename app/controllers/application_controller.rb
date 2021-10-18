class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication,
          ActionController::StrongParameters,
          Postii::CommonHelper

  def get_hello
    render json: CommonHelper.error!('MSG00001'),
           status: :ok
  end

end
