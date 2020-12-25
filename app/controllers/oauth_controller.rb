# https://readysteadycode.com/howto-integrate-google-calendar-with-rails
require 'google/apis/classroom_v1'
require 'googleauth'
require 'googleauth/web_user_authorizer'
require 'googleauth/stores/redis_token_store'
require 'redis'

class OauthController < ApplicationController
  before_action :authenticate_user!

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to courses_oauth_url
  end

  def courses_oauth
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::ClassroomV1::ClassroomService.new
    service.authorization = client

    @course_list = service.list_courses teacher_id: 'me'
    @course_list.to_h[:courses].each do |course|
      created_course = Course.find_or_initialize_by(classroom_id: course[:id])
      created_course.update!(
        {
          name: course[:name],
          section: course[:section],
          description: course[:description],
          creation_time: DateTime.parse(course[:creation_time]),
          enrollment_code: course[:enrollment_code],
          course_state: course[:course_state],
          link: course[:alternate_link],
          user: current_user,
        }
      )

      announcements = service.list_course_announcements(course[:id]).announcements
      course_works = service.list_course_works(course[:id]).course_work
      course_work_materials = service.list_course_course_work_materials(course[:id]).course_work_material

      unless announcements.nil?
        announcements.each do |announcement|
          Announcement.find_or_initialize_by(classroom_id: announcement.id).update!(
            {
              course: created_course,
              text: announcement.text,
              creation_time: DateTime.parse(announcement.creation_time),
              all_students: (announcement.assignee_mode == 'ALL_STUDENTS'),
              materials: (announcement.materials.size if announcement.materials)
            }
          )
        end
      end

      unless course_works.nil?
        course_works.each do |course_work|
          CourseWork.find_or_initialize_by(classroom_id: course_work.id).update!(
            {
              course: created_course,
              title: course_work.title,
              description: course_work.description,
              creation_time: DateTime.parse(course_work.creation_time),
              all_students: (course_work.assignee_mode == 'ALL_STUDENTS'),
              materials: (course_work.materials.size if course_work.materials),
              work_type: course_work.work_type,
              due_date: course_work.due_date
            }
          )
        end
      end

      unless course_work_materials.nil?
        course_work_materials.each do |course_work_material|
          CourseWorkMaterial.find_or_initialize_by(classroom_id: course_work_material.id).update!(
            {
              course: created_course,
              title: course_work_material.title,
              description: course_work_material.description,
              creation_time: DateTime.parse(course_work_material.creation_time),
              all_students: (course_work_material.assignee_mode == 'ALL_STUDENTS'),
              materials: (course_work_material.materials.size if course_work_material.materials)
            }
          )
        end
      end
    end
    redirect_to courses_path
  rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end

  private

  def client_options
    {
      client_id: Rails.application.credentials.dig(:google, :google_client_id),
      client_secret: Rails.application.credentials.dig(:google, :google_client_secret),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: [
        Google::Apis::ClassroomV1::AUTH_CLASSROOM_COURSES_READONLY,
        Google::Apis::ClassroomV1::AUTH_CLASSROOM_ROSTERS_READONLY,
        Google::Apis::ClassroomV1::AUTH_CLASSROOM_ANNOUNCEMENTS_READONLY,
        Google::Apis::ClassroomV1::AUTH_CLASSROOM_COURSEWORK_STUDENTS_READONLY,
        Google::Apis::ClassroomV1::AUTH_CLASSROOM_COURSEWORKMATERIALS_READONLY
      ],
      redirect_uri: callback_url,
      additional_parameters: {
        hd: '*'
      }
    }
  end
end
