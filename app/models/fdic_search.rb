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
            result.xpath("td/font").each_with_index do |column, index|
              row.merge!(FIELDS[index].to_sym => column.text.strip == '0' ? '' : column.text.strip)
            end
            results << row
          end
        end
      end
    end
    return {:results => results, :total => results.size}
  end
end

    
    