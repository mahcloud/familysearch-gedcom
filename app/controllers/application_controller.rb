class ApplicationController < ActionController::Base
	protect_from_forgery

	protected

	def current_user
		return unless session[:user_id]

		begin
			@current_user ||= User.find(session[:user_id])
		rescue
			nil
		end
	end

	helper_method :current_user

	def logged_in?
		current_user.is_a? User
	end

	helper_method :logged_in?

	def require_login
		unless logged_in?
			session[:original_uri] = request.url
			flash[:error] = "You must be logged in to access this page."
			redirect_to new_session_path
		end
	end

	helper_method :require_login
end
