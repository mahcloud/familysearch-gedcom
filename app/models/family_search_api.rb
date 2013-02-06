class FamilySearchApi
  LOGIN_URL = "sandbox.familysearch.org/identity/v2/login"
  TREE_URL = "sandbox.familysearch.org/familytree/v2/person"
  PLACE_URL = "sandbox.familysearch.org/authorities/v1/place"
  
  def self.dev_key
    config = YAML.load_file("#{Rails.root}/config/familysearch.yml")[Rails.env]
    config['web_key']
  end
  
  def self.query_session_id(username, password)
    begin
      xml = RestClient.get "https://"+username+":"+password+"@"+LOGIN_URL, :params => {:key => dev_key}
      if xml.code == 200
        f = Nokogiri::XML(xml)
        return f.xpath('//*[@id]').attr('id').to_s
      end
    rescue => e
    end
    false
  end

	def self.authenticated?
		if logged_in? && has_fsa?
			return current_user.family_search_account.fetch_session_id?
		end
		return false
	end

	def self.query_tree(session_id, id)
		begin
			xml = RestClient.get "https://api-user-3316:1a41@"+TREE_URL, :params => {:sessionId => session_id}
			if xml.code == 200
				f = Nokogiri::XML(xml)
				return xml
			end
		rescue => e
		abort(e.message)
		end
		nil
	end
end
