class UpdateCompletedToTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :completed, :boolean, default: 0
  end
end
