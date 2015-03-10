json.array!(@moments) do |moment|
  json.extract! moment, :id
  json.url moment_url(moment, format: :json)
end
