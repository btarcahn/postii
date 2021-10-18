class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication,
          ActionController::StrongParameters,
          Postii::Common::Helpers

  def get_hello
    render json: Helpers.error!('MSG00001'),
           status: :ok
  end

end
