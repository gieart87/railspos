json.extract! product, :id, :sku, :name, :slug, :price, :description, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
