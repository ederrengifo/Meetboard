class AddIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :gid, :string
    add_column :events, :description, :string
    add_column :events, :hangout_link, :string
  end
end
