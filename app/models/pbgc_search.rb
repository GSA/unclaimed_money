class PbgcSearch
  DEFAULT_PARAMS = {:commandAction => "indvSearch1", :wc1 => "exact", :company1 => "", :wc2 => "contains", :state1 => "0"} 
  FIELDS = ["name", "claim_url", "company", "last_known_address"]
  
  def self.search_for(last_name, options = {})
    response = HTTParty.post("http://search.pbgc.gov/mp/results.aspx", {:body => DEFAULT_PARAMS.merge(:lname1 => last_name)})
    if response.code == 200
      if response.body =~ /not in PBGC's unclaimed pensions database/
        results = []
      else
        results = []
        doc = Nokogiri::HTML(response.body)
        doc.xpath("//table[@class='mp']/tr").each_with_index do |row, index|
          if index == 0
            next
          else
            result = {}
            result[:name] = row.xpath("th/a").text.titleize
            result[:claim_url] = row.xpath("th/a").attribute("href").value
            result[:company] = row.xpath("td").first.text.strip.titleize
            result[:last_known_address] = row.xpath("td").last.text.strip
            results << result
          end
        end
      end
      return {:results => results, :total => results.size}
    end
    rescue
      return {:results => [], :total => 0}
    
  end
end

    
