class FamilysearchApi
  LOGIN_URL = "sandbox.familysearch.org/identity/v2/login"
  TREE_URL = "sandbox.familysearch.org/familytree/v2/person"
  PLACE_URL = "sandbox.familysearch.org/authorities/v1/place"
  
  def dev_key
    config = YAML.load_file("#{Rails.root}/config/familysearch.yml")[Rails.env]
    return config['web_key']
  end
  
  def session_id
    session_id = false
    u = User.find(1)
    if u.fs_session_update.nil? || u.fs_session_id.nil? || (u.fs_session_update < (Time.now - 3.hour))
      begin
        xml = RestClient.get "https://"+u.fs_username+":"+u.fs_password+"@"+LOGIN_URL, :params => {:key => dev_key}
        if xml.code == 200
          f = Nokogiri::XML(xml)
          u.fs_session_id = f.xpath('//*[@id]').attr('id').to_s
          u.fs_session_update = Time.now
          u.save
          session_id = u.fs_session_id
        end
      rescue => e
      end
    else
      session_id = u.fs_session_id
    end
    return session_id
  end
end
