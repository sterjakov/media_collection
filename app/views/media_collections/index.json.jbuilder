json.array!(@media_collections) do |media_collection|
  json.extract! media_collection, :id, :user_id, :name, :available
  json.url media_collection_url(media_collection, format: :json)
end
