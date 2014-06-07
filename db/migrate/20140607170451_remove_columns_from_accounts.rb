class RemoveColumnsFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :provider, :string
    remove_column :accounts, :uid, :string
  end
end
