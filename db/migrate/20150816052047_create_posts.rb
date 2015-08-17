class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :resource_id, null: false
      t.datetime :published
      t.string :image
      t.string :slug
      t.string :resource_type
      t.string :title
      t.string :status
      t.text :author
      t.text :raw_data

      t.timestamps
    end

    add_index(:posts, :status, order: {published: :desc}) unless index_exists?(:posts, :status)
    add_index(:posts, :resource_id, unique: true) unless index_exists?(:posts, :resource_id)
  end
end
