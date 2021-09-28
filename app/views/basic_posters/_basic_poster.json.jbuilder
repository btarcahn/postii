json.extract! basic_poster, :id, :poster_id, :title, :description, :security_question, :security_answer, :passcode, :created_at, :updated_at
json.url basic_poster_url(basic_poster, format: :json)
