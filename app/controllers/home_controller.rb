class HomeController < ApplicationController
  def index
    u = User.find(1)
    fs_user = u.family_search_user
    @output = fs_user.fetch_session_id
  end
end
