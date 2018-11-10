class AddTypeToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :type, :string
  end
end
