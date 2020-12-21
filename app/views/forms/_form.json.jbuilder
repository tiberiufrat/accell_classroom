json.extract! form, :id, :url, :response_url, :title, :thumbnail, :created_at, :updated_at
json.url form_url(form, format: :json)
