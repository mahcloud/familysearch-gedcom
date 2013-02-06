class AncestryAccount < ActiveRecord::Base
  attr_accessible :username, :password, :session_id, :session_update, :user_id
  belongs_to :user

  def fetch_session_id
    if session_update.nil? || session_id.nil? || (session_update < (Time.now - 3.hour))
    end
    true
  end
end
