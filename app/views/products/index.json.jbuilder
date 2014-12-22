json.array!(@products) do |product|
  json.extract! product, :id, :name, :pid, :url, :store_id, :isbn, :isbn10, :active
  json.url product_url(product, format: :json)
end
