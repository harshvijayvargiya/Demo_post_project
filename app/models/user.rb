class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ratyrate_rater
  devise :invitable, :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]

    has_many :posts, dependent: :destroy
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
    
end
