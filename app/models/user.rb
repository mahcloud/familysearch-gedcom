class User < ActiveRecord::Base
  attr_accessible :fs_username, :fs_password, :fs_session_id, :fs_session_update
end
