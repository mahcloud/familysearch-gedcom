class CreateFamilySearchUsers < ActiveRecord::Migration
  def change
    create_table :family_search_users do |t|
      t.integer :user_id, :null => false
      t.string :username, :null => false
      t.string :password, :null => false
      t.string :session_id
      t.timestamp :session_update
      t.timestamps
    end

    add_index :family_search_users, :user_id, :unique => true
  end
end
