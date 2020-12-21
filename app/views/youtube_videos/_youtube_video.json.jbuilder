json.extract! youtube_video, :id, :classroom_id, :title, :link, :thumbnail, :created_at, :updated_at
json.url youtube_video_url(youtube_video, format: :json)
