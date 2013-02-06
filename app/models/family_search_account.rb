require 'digest'
class FamilySearchAccount < ActiveRecord::Base
	attr_accessible :username, :password, :session_id, :session_update, :user_id
	
	validates :username,
	:presence => true,
	:length => { :within => 4..50 }

	validates :password,
	:presence => true,
	:length => { :within => 4..50 }

	belongs_to :user

	def fetch_session_id?
		if session_update.nil? || session_id.nil? || (session_update < (Time.now - 3.hour))
			id = FamilySearchApi::query_session_id(username, password)
			unless id == false
				update_attributes({ :session_id => id, :session_update => Time.now })
				return true
			end
		else
			return true
		end
		return false
	end
end
