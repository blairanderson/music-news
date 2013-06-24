json.array!(@submissions) do |submission|
  json.extract! submission, :title, :body, :user_id
  json.url submission_url(submission, format: :json)
end