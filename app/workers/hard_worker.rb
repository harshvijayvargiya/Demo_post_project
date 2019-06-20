class HardWorker
  include Sidekiq::Worker

  def perform(email)
        UserMailer.sample_email(email).deliver
  end
end
