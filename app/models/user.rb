require 'digest'
class User < ActiveRecord::Base
	attr_accessible :name, :email, :password

	attr_accessor :password

	validates :email,
		:presence => true,
		:uniqueness => true,
		:length => { :within => 5..50 },
		:format => { :with => /^[^@[\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

	validates :password,
		:presence => true,
		:confirmation => true,
		:length => { :within => 6..25 }
		:if => :password_required?

	has_one :family_search_user

	before_save :encrypt_new_password

	def self.authenticate(email, password)
		user = find_by_email(email)
		return user if user && user.authenticated?(password)
	end

	def authenticated?(password)
		self.password
	end

	protected
	
	def encrypt_new_password
		return if password.blank?
		self.password = encrypt(password)
	end

	def password_required?
		password.blank? || password.present?
	end

	def encrypt(string)
		Digest::SHA1.hexdigest(string)
	end
end
