class User < ApplicationRecord  
  has_many :sessions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  class << self
    def from_oauth(auth)
      find_or_create_by(email: auth.info.email) do |u|
        u.name = auth.info.name
        u.email = auth.info.email
        # u.uid = auth.uid
      end
    end
  end
end
