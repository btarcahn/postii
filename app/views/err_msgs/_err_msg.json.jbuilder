json.extract! err_msg, :id, :err_code, :message, :reason, :component, :additional_note, :created_at, :updated_at
json.url err_msg_url(err_msg, format: :json)
