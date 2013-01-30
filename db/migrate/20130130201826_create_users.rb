class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fs_username
      t.string :fs_password
      t.string :fs_session_id
      t.timestamps
    end
  end
end
