class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :type
      t.string :title
      t.string :url
      t.string :embed
      t.string :active

      t.timestamps
    end
  end
end
