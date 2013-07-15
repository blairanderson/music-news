class AddThumbnailUrlToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :thumbnail_url, :string
  end
end
