# frozen_string_literal: true

require 'google/apis/people_v1'
require 'google/api_client/client_secrets.rb'

class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # respond_to :json

  People = Google::Apis::PeopleV1
  def contacts
    secrets = Google::APIClient::ClientSecrets.new(
      'web' =>
        {
          'access_token' => current_user.token,
          'refresh_token' => current_user.refresh_token,
          'client_id' => Rails.application.secrets[:google_client_id],
          'client_secret' => Rails.application.secrets[:google_secret]
        }
    )
    service = People::PeopleServiceService.new
    service.authorization = secrets.to_authorization
    response = service.list_person_connections(
      'people/me',
      person_fields: %w[names emailAddresses phoneNumbers]
    )
    render json: response
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :email,:role]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update,keys: added_attrs)
    # devise_parameter_sanitizer.permit(:accept_invitation, keys: [:email, :password])
  end

end
