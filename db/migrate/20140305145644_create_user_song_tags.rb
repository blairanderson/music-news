class CreateUserSongTags < ActiveRecord::Migration
  def change
    create_table :user_song_tags do |t|
      t.integer :user_id, null: false, default: 0
      t.integer :song_id, null: false, default: 0
      t.integer :tag_id, null: false, default: 0

      t.timestamps
    end
    add_index :user_song_tags, :user_id
    add_index :user_song_tags, :song_id
    add_index :user_song_tags, :tag_id
    add_index :user_song_tags, [:tag_id, :user_id, :song_id], unique: true
  end
end
