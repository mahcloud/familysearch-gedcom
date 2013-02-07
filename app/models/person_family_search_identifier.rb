class PersonFamilySearchIdentifier < ActiveRecord::Base
  attr_accessible :person_id, :family_search_id

  belongs_to :person
end
