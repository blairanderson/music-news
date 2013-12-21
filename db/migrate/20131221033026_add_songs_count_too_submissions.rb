class AddSongsCountTooSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :songs_count, :integer, default: 0
  end
end
