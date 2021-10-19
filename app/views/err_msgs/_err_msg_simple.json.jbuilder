json.extract! err_msg, :err_code, :message
json.url err_msg_url(err_msg, format: :json)
