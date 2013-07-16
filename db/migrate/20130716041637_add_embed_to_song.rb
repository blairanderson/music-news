class AddEmbedToSong < ActiveRecord::Migration
  def change
    remove_column :songs, :embed
    add_column :songs, :embed, :text
  end
end
