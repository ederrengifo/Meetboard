class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.string :gid
      t.string :email
      t.string :name
      t.boolean :organizer
      t.string :response

      t.timestamps
    end
  end
end
