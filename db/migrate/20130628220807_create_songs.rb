class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :type
      t.string :url
      t.string :embed
      t.string :active
      t.integer :submission_id

      t.timestamps
    end
    add_index :songs, :submission_id
  end
end
