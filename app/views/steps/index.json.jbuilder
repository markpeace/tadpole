json.array!(@steps) do |step|
  json.extract! step, :user_id, :brew_id, :title, :days, :order, :date, :completed, :update_inventory
  json.url step_url(step, format: :json)
end
