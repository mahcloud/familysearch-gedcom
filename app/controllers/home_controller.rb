class HomeController < ApplicationController
	def index
		if logged_in?
			fs_account = current_user.family_search_account
			@tree = 'No tree'
			if fs_account.nil?
				@output = "Please attach a familysearch.org account"
			else
				if fs_account.fetch_session_id?
					@output = "Successfully connected to familysearch.org."
					@tree = fs_account.fetch_tree()
				else
					@output = "Failed to connect to familysearch.org."
				end
			end

		end
	end
end
