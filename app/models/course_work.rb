class CourseWork < ApplicationRecord
  belongs_to :course
  has_many :drive_files, as: :drive_fileable
  has_many :youtube_videos, as: :youtube_videoable
  has_many :links, as: :linkable
  has_many :forms, as: :formable

  def translated_work_type
    case work_type
    when 'ASSIGNMENT'
      I18n.t('course_work.work_type.assignment')
    when 'SHORT_ANSWER_QUESTION'
      I18n.t('course_work.work_type.short_question')
    when 'MULTIPLE_CHOICE_QUESTION'
      I18n.t('course_work.work_type.multiple_choice')
    else
      I18n.t('course_work.work_type.unspecified')
    end
  end
end
