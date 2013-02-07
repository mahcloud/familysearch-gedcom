require 'nokogiri'
require 'rexml/document'
class FamilySearchApi
  LOGIN_URL = "/identity/v2/login"
  PERSON_URL = "/familytree/v2/person"
  PEDIGREE_URL = "/familytree/v2/pedigree"
  PLACE_URL = "/authorities/v1/place"
  
  def self.dev_key
    config = YAML.load_file("#{Rails.root}/config/familysearch.yml")[Rails.env]
    config['web_key']
  end
  
  def self.api_url
    config = YAML.load_file("#{Rails.root}/config/familysearch.yml")[Rails.env]
    config['url']
  end
  
  def self.query_session_id(username, password)
    begin
      xml = RestClient.get "https://"+username+":"+password+"@"+api_url+LOGIN_URL, :params => {:key => dev_key}
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

	def self.query_tree(session_id, pid = nil)
		begin
			url = "https://"+api_url+PEDIGREE_URL
			unless pid.nil?
				url += "/"+pid
			end
			xml = RestClient.get url, :params => {:sessionId => session_id}
			if xml.code == 200
				str = ""
				doc = REXML::Document.new(xml)
				elements = REXML::XPath.match(doc.root)
				persons = []
				pids = []
				doc.root.each_recursive do |elem|
					persons << elem.to_s if elem.name == "person"
					pids << elem.attribute('id').to_s if elem.name == "person"
				end
				persons.each_with_index do |person, index|
					parents = []
					name = ""
					fspid = ""
					doc = REXML::Document.new(person)
					elements = REXML::XPath.match(doc.root)
					doc.root.each_recursive do |elem|
						parents << elem.to_s if elem.name == "parent"
						if elem.name == "fullText"
							name = elem.text.to_s
						end
					end
					str += pids[index]+"=>"+name
					parents.each do |parent|
						str += "Parent: "+parent+"----------------------------------------------------"
					end

				end
				return str
				#f = Nokogiri::XML(xml)
				#return xml
				#return f.xpath("*[1]")
				#return f.xpath("*[2]")
				#var = ""
				#f.xpath("//*[@id]").each do |person|
				#	var += "New Person: "+person.attr('id').to_s+"------------------------------------------------------------------------------------------"
				#	person.xpath("//*[@gender]").each do |parent|
				#		var += "Parent: "+parent.attr('id').to_s
				#	end
				#end
				#return var
			end
			#doc = REXML::Document.new(xml)
			#doc.elements.each('persons/person') do |p|
			#	return p.text
			#end
		rescue => e
		abort(e.message)
		end
		nil
	end
end
