json.extract! report, :id, :date_start, :date_end, :user_id, :created_at, :updated_at
json.url report_url(report, format: :json)
