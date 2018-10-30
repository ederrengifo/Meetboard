class AddNotesToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :note, :text
  end
end
