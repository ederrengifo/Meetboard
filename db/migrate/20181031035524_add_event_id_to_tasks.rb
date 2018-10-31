class AddEventIdToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :event_id, :string
  end
end
