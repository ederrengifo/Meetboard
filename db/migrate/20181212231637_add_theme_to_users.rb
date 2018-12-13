class AddThemeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :theme, :string, :null => false, :default => "dark"
  end
end
