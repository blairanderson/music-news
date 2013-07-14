class CreateKeychains < ActiveRecord::Migration
  def change
    create_table :keychains do |t|
      t.string :api_secret
      t.string :api_token
      t.string :auth_credentials_secret
      t.string :auth_credentials_token
      t.integer :user_id

      t.timestamps
    end
    add_index :keychains, :user_id
  end
end
