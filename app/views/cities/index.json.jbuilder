json.array!(@cities) do |city|
  json.extract! city, :id, :address, :display_name, :latitude, :longitude, 
  json.url city_url(city, format: :json)
end
