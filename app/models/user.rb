# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
                                                               message: 'only allows letters' }, length: { maximum: 50 }
  validates :contact_number, presence: true, numericality: { only_integer: true }, length: { minimum: 10 }
  has_many :comments, dependent: :destroy
  validates :email, email_format: { message: "doesn't look like an email address" }

  ratyrate_rater
  mount_uploader :profile_picture
  devise :invitable, :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy


  # [:user, :admin] this is array that's why default role save is 0 (user)
  enum role: [:user, :admin]

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #   user.token = auth.credentials.token
  #   user.expires = auth.credentials.expires
  #   user.expires_at = auth.credentials.expires_at
  #   user.refresh_token = auth.credentials.refresh_token
  # end
  # end

  #   def self.from_omniauth(auth)
  #   # Creates a new user only if it doesn't exist
  #   where(email: auth.info.email).first_or_initialize do |user|
  #     user.token = auth.credentials.token
  #     user.expires = auth.credentials.expires
  #     user.expires_at = auth.credentials.expires_at
  #     user.refresh_token = auth.credentials.refresh_token
  #   end
  # end

  # for access current_user into model / check application controller

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end


  def after_confirmation
    message = contact_number
    fname = first_name
    HardWorker.perform_in(1.minutes, email) # send welcome mail after 1.mint
    TwilioTextMessenger.new(message, fname).call # getting mobile no(message) and name(fname)
  end

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user
      end
    end
    end

  private
end
