class Cleanup < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
    create_table :users do |t|
      t.text :name, null: false
      t.text :email, null: false, unique: true
    end
    add_index :users, :email, unique: true

    create_table :sessions do |t|
      t.text :token, null: false
      t.text :refresh_token, null: false
      t.datetime :expires_at, null: false

      t.references :user, null: false
      t.timestamps
    end

    drop_table :calendars
    create_table :calendars do |t|
      t.text :items, null: false, default: ""

      t.references :user, null: false
      t.timestamps
    end

    drop_table :events
    create_table :events do |t|
      t.text :summary, null: false, default: ""
      t.datetime :start
      t.datetime :end
    
      t.timestamps
    end
  end
end
