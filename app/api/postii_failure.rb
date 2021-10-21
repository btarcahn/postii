class PostiiFailure < Devise::FailureApp
  include AlertHelpers

  def respond
    http_auth
    self.content_type = 'application/json; charset=utf-8'
    if warden_options[:insufficient_authority]
      self.response_body = message!('ERR00009').to_json
    else
      # self.response_body = http_auth_body
      # Wraps this to conforms  postii's format.
      self.response_body = message!('', [], http_auth_body).to_json
    end
  end
end
