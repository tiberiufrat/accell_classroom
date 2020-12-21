require 'google/apis/classroom_v1'
require 'googleauth'

class OmniauthController < Devise::OmniauthCallbacksController
  def google_oauth2
    # byebug
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    @auth = request.env['omniauth.auth']['credentials']
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Google. Please try again later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please try again later.'
    redirect_to new_user_registration_url
  end
end
