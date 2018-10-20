class User < ApplicationRecord  
  has_many :sessions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.google_refresh_token = auth.credentials.refresh_token
      user.google_token = auth.credentials.token
      user.oauth_expires_at = auth.credentials.expires_at
    end
  end
end
