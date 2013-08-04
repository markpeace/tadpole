json.array!(@brews) do |brew|
  json.extract! brew, :user_id, :name, :date
  json.url brew_url(brew, format: :json)
end
