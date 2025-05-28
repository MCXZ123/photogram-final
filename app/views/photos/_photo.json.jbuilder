json.extract! photo, :id, :caption, :owner_id, :comments_count, :likes_count, :created_at, :updated_at
json.url photo_url(photo, format: :json)
