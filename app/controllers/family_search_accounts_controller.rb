class FamilySearchAccountsController < ApplicationController
	def new
		if has_fsa?
			redirect_to update_fsa_path
		else
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

	def edit
		if has_fsa?
			@fs_account = current_user.family_search_account
		else
			redirect_to link_fsa_path
		end
	end

	def update
		@fs_account = current_user.family_search_account
		@fs_account.session_id = nil
		@fs_account.session_update = nil
		if @fs_account.update_attributes(params[:family_search_account])
			redirect_to root_path, :notice => 'FamilySearch.org account credentially successfully saved.'
		else
			render :action => 'edit'
		end
	end
end
