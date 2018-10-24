class AddTitleToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :title, :string
    add_column :events, :starts, :datetime
    add_column :events, :ends, :datetime
  end
end
