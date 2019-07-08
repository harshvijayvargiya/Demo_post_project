# frozen_string_literal: true

class RegistrationSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :contact_number, :profile_picture
end
