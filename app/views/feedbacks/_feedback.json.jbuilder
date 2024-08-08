json.extract! feedback, :id, :message, :image, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
json.image url_for(feedback.image)
