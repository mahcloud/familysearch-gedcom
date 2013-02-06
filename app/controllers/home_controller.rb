class HomeController < ApplicationController
	def index
		if logged_in?
			fs_account = current_user.family_search_account
			@output = "Please attach a familysearch.org account"
			unless fs_account.nil?
				if fs_account.fetch_session_id?
					@output = "Successfully connected to familysearch.org."
				else
					@output = "Failed to connect to familysearch.org."
				end
			end

		end
	end
end
