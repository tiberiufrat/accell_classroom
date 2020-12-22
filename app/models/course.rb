class Course < ApplicationRecord
  belongs_to :user
  has_many :announcements, dependent: :destroy
  has_many :course_work_materials, dependent: :destroy
  has_many :course_works, dependent: :destroy
end
