module AccountServices::Helpers
  def token(email)
    payload = { email: email }
    JWT.encode(payload, hmac_secret, 'HS256')
  end

  def hmac_secret
    ENV['API_SECRET_KEY']
  end

  def client_has_valid_token?
    !!current_user_id
  end

  def current_user_id
    begin
      token = request.headers['Authorization']
      decoded_array = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
      payload = decoded_array.first
    rescue #JWT::VerificationError
      return nil
    end
    payload['email']
  end

  def require_login
    unless client_has_valid_token?
      render json: CommonHelper.construct_error_message('ERR00004'),
             status: :unauthorized
    end
  end
end
