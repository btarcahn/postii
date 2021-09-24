json.extract! quest, :id, :quest_type, :mandatory, :question, :answer, :basic_poster_id, :created_at, :updated_at
json.url quest_url(quest, format: :json)
