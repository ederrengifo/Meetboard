class Event < ApplicationRecord
    belongs_to :user, optional: true
    self.primary_key = :gid
    has_many :tasks, dependent: :destroy, foreign_key: "event_id"

    def to_param
        self.gid
    end

end
