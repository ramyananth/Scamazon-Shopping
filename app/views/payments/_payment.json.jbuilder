json.extract! payment, :id, :name, :card_number, :expiry_date, :cvv, :created_at, :updated_at
json.url payment_url(payment, format: :json)
