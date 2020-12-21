# https://readysteadycode.com/howto-integrate-google-calendar-with-rails
require 'google/apis/classroom_v1'
require 'googleauth'
require 'googleauth/web_user_authorizer'
require 'googleauth/stores/redis_token_store'
require 'redis'

class OauthController < ApplicationController
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

    @course_list = service.list_courses page_size: 10
    @course_list.to_h[:courses].each { |course| puts course[:id] }
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
      redirect_uri: callback_url
    }
  end
end
