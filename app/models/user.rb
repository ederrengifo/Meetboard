class User < ApplicationRecord  
  has_many :events
  has_many :tasks, through: :events
  has_many :attendees, through: :events

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
