class UserMailer < ApplicationMailer
default from: "no-reply@thoughtwin.com"

  def sample_email(email)
    # binding.pry
    @email = email
    mail(to: email, subject: 'Invites You to touch with us')
  end
end
