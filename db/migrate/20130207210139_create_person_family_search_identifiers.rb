class CreatePersonFamilySearchIdentifiers < ActiveRecord::Migration
  def change
    create_table :person_family_search_identifier do |t|
      t.integer :person_id
      t.string :family_search_id
      t.timestamps
    end
  end
end
