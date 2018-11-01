class AddCreatorAndLocationToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :creator, :string
    add_column :events, :location, :string
  end
end
