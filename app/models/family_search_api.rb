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
				doc = REXML::Document.new(xml)
				elements = REXML::XPath.match(doc.root)
				persons = []
				pids = []
				doc.root.each_recursive do |elem|
					persons << elem.to_s if elem.name == "person"
					pids << elem.attribute('id').to_s if elem.name == "person"
				end
				persons.each_with_index do |person, index|
					father_id = ""
					mother_id = ""
					name = ""
					doc = REXML::Document.new(person)
					elements = REXML::XPath.match(doc.root)
					doc.root.each_recursive do |elem|
						if elem.name == "parent" && elem.attribute('gender').to_s == "Male"
							father_id = elem.attribute('id').to_s
						end
						if elem.name == "parent" && elem.attribute('gender').to_s == "Female"
							mother_id = elem.attribute('id').to_s
						end
						if elem.name == "fullText"
							name = elem.text.to_s
						end
					end
					fsp = Person.new
					fsp.name = name
					if father_id != ""
						father = Person.new
						father.save
						father_fs_id = PersonFamilySearchIdentifier.new
						father_fs_id.family_search_id = father_id
						father_fs_id.save
						#father_fs_id = father.person_family_search_identifiers.build({:family_search_id => father_id})
						fsp.father_id = father.id
					end
					if mother_id != ""
						mother = Person.new
						mother.save
						mother_fs_id = PersonFamilySearchIdentifier.new
						mother_fs_id.family_search_id = mother_id
						mother_fs_id.save
					#	mother_fs_id = mother.person_family_search_identifier.build(mother_id)
						fsp.mother_id = mother.id
					end
					#fsp.user_id = current_user.id
					fsp.save
				end
			end
		rescue => e
		return e.message
		end
		nil
	end
end
