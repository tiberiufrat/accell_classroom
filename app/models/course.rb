class Course < ApplicationRecord
  belongs_to :user
  has_many :announcements
  has_many :course_work_materials
  has_many :course_works
end
