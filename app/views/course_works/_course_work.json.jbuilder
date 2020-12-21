json.extract! course_work, :id, :classroom_id, :title, :description, :materials, :creation_time, :due_date, :work_type, :all_students, :course_id, :created_at, :updated_at
json.url course_work_url(course_work, format: :json)
