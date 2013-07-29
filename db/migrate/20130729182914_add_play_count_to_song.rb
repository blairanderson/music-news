class AddPlayCountToSong < ActiveRecord::Migration
  def change
    add_column :songs, :stream_url, :string
    add_column :songs, :play_count, :integer, :default => 0
    add_column :songs, :comment_count, :integer, :default => 0
    add_column :songs, :download_count, :integer, :default => 0
    add_column :songs, :playback_count, :integer, :default => 0
    add_column :songs, :favoritings_count, :integer, :default => 0
  end
end
