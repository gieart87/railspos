json.extract! payment, :id, :payment_date, :amount, :change_amount, :order_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
