class HomeController < ApplicationController
  def index
    fs_api = FamilysearchApi.new
    @output = fs_api.session_id
  end
end
