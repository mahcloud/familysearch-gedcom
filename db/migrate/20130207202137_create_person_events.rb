class CreatePersonEvents < ActiveRecord::Migration
  def change
    create_table :person_events do |t|
      t.integer :person_id
      t.string :type
      t.timestamp :date
      t.string :place

      t.timestamps
    end
  end
end
