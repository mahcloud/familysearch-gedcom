class PersonEvent < ActiveRecord::Base
  attr_accessible :date, :person_id, :place, :type

  belongs_to :person
end
