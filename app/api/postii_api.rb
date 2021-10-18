class PostiiAPI < Grape::API
  version 'v1', using: :path
  format :json

  get do
    present code: '', message: 'Welcome to API::V1'
  end

  post do
    status :bad_request
    present code: '', message: 'POST request not allowed'
  end

  put do
    status :bad_request
    present code: '', message: 'PUT request not allowed'
  end

  patch do
    status :bad_request
    present code: '', message: 'PATCH request not allowed'
  end

  delete do
    status :bad_request
    present code: '', message: 'DELETE request not allowed'
  end

  mount Postii::V1::Users
  mount Postii::V1::Alerts
  mount Postii::V1::BasicPosters
  mount Postii::V1::Creators
end
