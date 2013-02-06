class CreateAncestryAccounts < ActiveRecord::Migration
  def change
    create_table :ancestry_accounts do |t|
      t.integer :user_id
      t.string :username
      t.string :password
      t.string :session_id
      t.timestamp :session_update

      t.timestamps
    end
  end
end
