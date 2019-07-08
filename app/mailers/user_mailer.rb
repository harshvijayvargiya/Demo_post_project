# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'no-reply@thoughtwin.com'

  def sample_email(email)
    # binding.pry
    @email = email
    mail(to: email, subject: 'Invites You')
  end
end
