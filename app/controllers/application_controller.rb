class ApplicationController < ActionController::API
  include ActionController::StrongParameters
  include ActionController::MimeResponds
  include AlertHelpers
  include RolesManager

end
