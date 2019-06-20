class HardWorker
  include Sidekiq::Worker

  def perform(email)
    # binding.pry
    UserMailer.sample_email(email).deliver
  end
end
