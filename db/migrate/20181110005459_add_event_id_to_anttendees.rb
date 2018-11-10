class AddEventIdToAnttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :event_id, :string
  end
end
