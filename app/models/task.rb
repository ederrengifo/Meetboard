class Task < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :event

    private

    def default_value
        self.completed ||= false
        nil
    end
end
