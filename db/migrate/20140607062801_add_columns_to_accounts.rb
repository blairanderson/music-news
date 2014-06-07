class AddColumnsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :provider, :string
    add_column :accounts, :uid, :string
    add_index :accounts, [:provider, :uid], unique: true
  end
end
