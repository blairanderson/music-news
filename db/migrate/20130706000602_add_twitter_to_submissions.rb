class AddTwitterToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :twitter, :string
    add_column :submissions, :email, :string
  end
end
