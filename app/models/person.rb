class Person < ActiveRecord::Base
  attr_accessible :name, :user_id, :father_id, :mother_id, :gender

  has_one :family_search_identifier
  has_one :person_birth_event
  has_one :person_death_event
end
