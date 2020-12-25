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
          new_announcement = Announcement.find_or_initialize_by(classroom_id: announcement.id)
          new_announcement.update!(
            {
              course: created_course,
              text: announcement.text,
              creation_time: DateTime.parse(announcement.creation_time),
              all_students: (announcement.assignee_mode == 'ALL_STUDENTS'),
              materials: (announcement.materials.size if announcement.materials)
            }
          )
          new_announcement.materials = get_materials(announcement.materials, new_announcement) if announcement.materials
        end
      end

      unless course_works.nil?
        course_works.each do |course_work|
          new_course_work = CourseWork.find_or_initialize_by(classroom_id: course_work.id)
          new_course_work.update!(
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
          new_course_work.materials = get_materials(course_work.materials, new_course_work) if course_work.materials
        end
      end

      unless course_work_materials.nil?
        course_work_materials.each do |course_work_material|
          new_course_work_material = CourseWorkMaterial.find_or_initialize_by(classroom_id: course_work_material.id)
          new_course_work_material.update!(
            {
              course: created_course,
              title: course_work_material.title,
              description: course_work_material.description,
              creation_time: DateTime.parse(course_work_material.creation_time),
              all_students: (course_work_material.assignee_mode == 'ALL_STUDENTS'),
              materials: (course_work_material.materials.size if course_work_material.materials)
            }
          )
          new_course_work_material.materials = get_materials(course_work_material.materials, new_course_work_material) if course_work_material.materials
        end
      end
    end
    redirect_to courses_path, notice: t('notices.courses_imported')
  rescue Google::Apis::AuthorizationError
    begin
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)

      retry
    rescue
      redirect_to redirect_path
    end
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

  def get_materials(materials, sender)
    material_objects = []
    materials.each do |material|
      case
      when material.drive_file
        drive_file = DriveFile.find_or_initialize_by(classroom_id: material.drive_file.drive_file.id)
        drive_file.update!(
          {
            title: material.drive_file.drive_file.title,
            link: material.drive_file.drive_file.alternate_link,
            thumbnail: material.drive_file.drive_file.thumbnail_url,
            drive_fileable: sender
          }
        )
        material_objects << drive_file
      when material.form
        form = Form.find_or_initialize_by(url: material.form.form_url)
        form.update!(
          {
            title: material.form.title,
            thumbnail: material.form.thumbnail_url,
            response_url: material.form.response_url,
            formable: sender
          }
        )
        material_objects << form
      when material.youtube_video
        youtube_video = YoutubeVideo.find_or_initialize_by(classroom_id: material.youtube_video.id)
        youtube_video.update!(
          {
            title: material.youtube_video.title,
            thumbnail: material.youtube_video.thumbnail_url,
            link: material.youtube_video.alternate_link,
            youtube_videoable: sender
          }
        )
        material_objects << youtube_video
      when material.link
        link = Link.find_or_initialize_by(url: material.link.url)
        link.update!(
          {
            title: material.link.title,
            thumbnail: material.link.thumbnail_url,
            linkable: sender
          }
        )
        material_objects << link
      end
    end
    return material_objects
  end
end
