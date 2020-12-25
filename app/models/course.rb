class Course < ApplicationRecord
  belongs_to :user
  has_many :announcements, dependent: :destroy
  has_many :course_work_materials, dependent: :destroy
  has_many :course_works, dependent: :destroy

  def status_badge
    case course_state
    when "ACTIVE"
         "<span class=\"badge badge-success\">#{ I18n.t('courses.status.active') }</span>"
    when "ARCHIVED"
      "<span class=\"badge badge-warning\">#{ I18n.t('courses.status.archived') }</span>"
    when "PROVISIONED"
      "<span class=\"badge badge-light\">#{ I18n.t('courses.status.provisioned') }</span>"
    when "DECLINED"
      "<span class=\"badge badge-danger\">#{ I18n.t('courses.status.declined') }</span>"
    when "SUSPENDED"
      "<span class=\"badge badge-secondary\">#{ I18n.t('courses.status.suspended') }</span>"
    else
      "<span class=\"badge badge-dark\">#{ I18n.t('courses.status.unknown') }</span>"
    end
  end
end
