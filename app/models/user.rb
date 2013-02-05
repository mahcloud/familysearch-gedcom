class User < ActiveRecord::Base
  attr_accessible :name, :email, :password
  
  validates :email,
  	:presence => true,
  	:uniqueness => true,
  	:length => { :within => 5..50 },
	:format => { :with => /^[^@[\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

  validates :password,
  	:presence => true,
  	:confirmation => true,
	:length => { :within => 5..25 }

  has_one :family_search_user
end
