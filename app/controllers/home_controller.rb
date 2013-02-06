class HomeController < ApplicationController
  def index
    u = current_user
    fs_account = u.family_search_account
    @output = "Please connect a family search account"
    unless fs_account.nil?
      if(fs_account.fetch_session_id)
        @output = "Successfully connected to familysearch."
      else
        @output = "Failed to connect to familysearch."
      end
    end
  end
end
