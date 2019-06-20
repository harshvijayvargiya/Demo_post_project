class UserMailer < ApplicationMailer
default from: "harsh@thoughtwin.com"

  def sample_email(email)
    # binding.pry
    @email = email
    mail(to: email, subject: 'Welcome Email')
  end
end
