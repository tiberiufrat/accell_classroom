class CourseWorkMaterial < ApplicationRecord
  belongs_to :course, dependent: :destroy
  has_many :drive_files, as: :drive_fileable
  has_many :youtube_videos, as: :youtube_videoable
  has_many :links, as: :linkable
  has_many :forms, as: :formable
end
