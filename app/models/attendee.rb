class Attendee < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :event, optional: true
end
