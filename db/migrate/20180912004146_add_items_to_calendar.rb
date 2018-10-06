class AddItemsToCalendar < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :items, :string
  end
end
