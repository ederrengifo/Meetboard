class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :event_id
      t.string :title

      t.timestamps
    end
  end
end
