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

	before_save :encrypt_new_password

	def fetch_session_id?
		if session_update.nil? || session_id.nil? || (session_update < (Time.now - 3.hour))
			id = FamilySearchApi::query_session_id(self)
			unless id == false
				update_attributes({ :session_id => id, :session_update => Time.now })
			else
				false
			end
		end
		true
	end
	
	protected
	
	def encrypt_new_password
		return if password.blank?
		self.password = encrypt(password)
	end

	def encrypt(string)
		Digest::SHA1.hexdigest(string)
	end
end
