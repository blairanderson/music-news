class AddViewCountToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :view_count, :integer, :default => 0
  end
end
