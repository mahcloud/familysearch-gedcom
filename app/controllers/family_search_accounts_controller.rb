class FamilySearchAccountsController < ApplicationController
	def new
		user = current_user
		@fs_account = user.family_search_account
		if(@fs_account.nil?)
			@fs_account = FamilySearchAccount.new
		end
	end
	
	def create
		user = current_user
		@fs_account = user.create_family_search_account(params[:family_search_account])
		if @fs_account.save
			redirect_to root_path, :notice => 'FamilySearch.org account credentials successfully saved.'
		else
			render :action => 'new'
		end
	end
end
