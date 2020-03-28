json.extract! feedback, :id, :name, :item_id, :comment, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
