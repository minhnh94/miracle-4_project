json.array!(@image_comments) do |image_comment|
  json.extract! image_comment, :id, :user_id, :image_id, :comment
  json.url image_comment_url(image_comment, format: :json)
end
