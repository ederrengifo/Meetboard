class AddEventTitleToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :event_title, :string
  end
end
