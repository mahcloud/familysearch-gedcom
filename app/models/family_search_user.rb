class FamilySearchUser < ActiveRecord::Base
  attr_accessible :username, :password, :session_id, :session_update, :user_id
  belongs_to :user

  def fetch_session_id
    if session_update.nil? || session_id.nil? || (session_update < (Time.now - 3.hour))
      id = FamilySearchApi::query_session_id(self)
      unless id == false
	update_attributes({ :session_id => id, :session_update => Time.now })
      else
        false
      end
    end
    true
  end

end
