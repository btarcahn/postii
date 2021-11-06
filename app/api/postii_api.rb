class PostiiAPI < Grape::API
  version 'v1', using: :path
  format :json

  desc 'Root API for Postii::V1'
  get do
    present code: '', message: 'Welcome to Postii::V1'
  end

  desc 'Root API for Postii::V1 (not allowed)'
  post do
    status :bad_request
    present code: '', message: 'POST request not allowed'
  end

  desc 'Root API for Postii::V1 (not allowed)'
  put do
    status :bad_request
    present code: '', message: 'PUT request not allowed'
  end

  desc 'Root API for Postii::V1 (not allowed)'
  patch do
    status :bad_request
    present code: '', message: 'PATCH request not allowed'
  end

  desc 'Root API for Postii::V1 (not allowed)'
  delete do
    status :bad_request
    present code: '', message: 'DELETE request not allowed'
  end

  mount Postii::V1::Users
  mount Postii::V1::Alerts
  mount Postii::V1::BasicPosters
  mount Postii::V1::Creators
  mount Postii::V1::ElevationRequests
  mount Postii::V1::Profile
end
