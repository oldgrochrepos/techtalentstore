json.array!(@products) do |product|
  json.extract! product, :id, :name, :unit_price, :description, :quantity, :brand, :model_num
  json.url product_url(product, format: :json)
end
