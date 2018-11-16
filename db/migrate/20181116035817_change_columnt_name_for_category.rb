class ChangeColumntNameForCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :type, :category
  end
end
