json.extract! course, :id, :classroom_id, :name, :section, :description, :creation_time, :enrollment_code, :course_state, :link, :user_id, :created_at, :updated_at
json.url course_url(course, format: :json)
