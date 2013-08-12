json.array!(@inventories) do |inventory|
  json.extract! inventory, :user_id, :label, :grams
  json.url inventory_url(inventory, format: :json)
end
