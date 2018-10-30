class Event < ApplicationRecord
    belongs_to :user, optional: true
    self.primary_key = :gid

    def to_param
        self.gid
    end

end
