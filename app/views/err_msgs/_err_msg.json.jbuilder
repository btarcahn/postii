json.extract! err_msg, :id, :created_at, :updated_at
json.url err_msg_url(err_msg, format: :json)
