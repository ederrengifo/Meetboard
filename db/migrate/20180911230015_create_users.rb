class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :google_token
      t.string :google_refresh_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
