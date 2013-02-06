class ChangeFamilySearchAccount < ActiveRecord::Migration
  def up
    rename_table :family_search_users, :family_search_accounts
  end

  def down
    rename_table :family_search_accounts, :family_search_users
  end
end
