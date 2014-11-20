json.array!(@entries) do |entry|
  json.extract! entry, :id, :diary_id, :question_id, :answer, :date
  json.url entry_url(entry, format: :json)
end
