class Report < ApplicationRecord
  idy
  belongs_to :user
  has_many :activities, dependent: :destroy

  after_create :gather_activities

  def gather_activities
    courses = self.user.courses
    courses.each do |course|
      unless course.announcements.empty?
        course.announcements.each do |announcement|
          if (self.date_start..self.date_end).cover? announcement.creation_time
            Activity.create!(
              {
                course: course,
                report: self,
                time: announcement.creation_time,
                title: I18n.translate('reports.added_announcement'),
                description: "„#{announcement.text}” #{announcement.materials ? '(' + I18n.translate('reports.with_materials', count: announcement.materials) + ')' : ''}, #{announcement.all_students ? I18n.translate('reports.for_all_students') : I18n.translate('reports.for_some_students')}"
              }
            )
          end
        end
      end

      unless course.course_works.empty?
        course.course_works.each do |course_work|
          if (self.date_start..self.date_end).cover? course_work.creation_time
            Activity.create!(
              {
                course: course,
                report: self,
                time: course_work.creation_time,
                title: I18n.translate('reports.added_course_work'),
                description: "„#{course_work.title}” #{course_work.materials ? '(' + I18n.translate('reports.with_materials', count: course_work.materials) + ')' : ''}, #{course_work.all_students ? I18n.translate('reports.for_all_students') : I18n.translate('reports.for_some_students')}"
              }
            )
          end
        end
      end

      unless course.course_work_materials.empty?
        course.course_work_materials.each do |course_work_material|
          if (self.date_start..self.date_end).cover? course_work_material.creation_time
            Activity.create!(
              {
                course: course,
                report: self,
                time: course_work_material.creation_time,
                title: I18n.translate('reports.added_course_work_material'),
                description: "„#{course_work_material.title}” #{course_work_material.materials ? '(' + I18n.translate('reports.with_materials', count: course_work_material.materials) + ')' : ''}, #{course_work_material.all_students ? I18n.translate('reports.for_all_students') : I18n.translate('reports.for_some_students')}"
              }
            )
          end
        end
      end
    end
  end
end
