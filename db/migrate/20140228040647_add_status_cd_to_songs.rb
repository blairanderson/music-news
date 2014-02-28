class AddStatusCdToSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :active, :string
    add_column :songs, :status_cd, :integer, default: 0, null: false
    add_index :songs, :status_cd
  end
end
