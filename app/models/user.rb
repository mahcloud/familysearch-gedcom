class User < ActiveRecord::Base
  attr_accessible :name, :email, :password
  has_one :family_search_user
end
