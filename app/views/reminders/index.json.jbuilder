json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :user_id, :by_phone, :by_email, :time
  json.url reminder_url(reminder, format: :json)
end
