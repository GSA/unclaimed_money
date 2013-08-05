class FdicSearch
  DEFAULT_PARAMS = {:source => "saveForm", :ValidForm => "true", :NameErr => "0", :R1 => "" , :TypeErr => "0", :St => "NONE", :StateErr => "0", :SrchStr => "", :SrchErr => "0"}
  FIELDS = ["reference_number", "fund_owner_name", "institution_name", "city", "state", "claim_number", "check_date", "check_number"]
  
  def self.search_for(last_name, options = {})
    response = HTTParty.post("http://www2.fdic.gov/funds/unclaimresponse.asp", {:body => DEFAULT_PARAMS.merge(:SrchName => last_name)})
    if response.code == 200
      if response.body =~ /No Records Found/
        results = []
      else
        results = []
        doc = Nokogiri::HTML(response.body)
        doc.xpath("//tr[@align='center']").each_with_index do |result, index|
          if index == 0
            next
          else 
            row = {}

            row[:reference_number] = result.xpath("td/font")[0].text.squish.titleize
            row[:fund_owner_name] = result.xpath("td/font")[1].text.squish.titleize
            row[:institution_name] = result.xpath("td/font")[2].text.squish.titleize
            row[:city] = result.xpath("td/font")[3].text.squish.titleize
            row[:state] = result.xpath("td/font")[4].text.squish
            row[:claim_number] = result.xpath("td/font")[5].text.squish.titleize
            row[:check_date] = result.xpath("td/font")[6].text.squish.titleize
            row[:check_number] = result.xpath("td/font")[7].text.squish.titleize

            results << row
          end
        end
      end
    end
    return {:results => results, :total => results.size}
  rescue # generic rescue clause to handle downed site
    return {:results => [], :total => 0}
  end
end

    
    