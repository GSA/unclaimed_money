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
      
        doc.xpath("//tr[@align='center']")[1..25].each_with_index do |result, index|
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
        end # .each_with_index do 
      end # if  response.body =~ /No Records Found/
    end # if response.code == 200
    return {:results => results, :total => results.size}
  rescue # generic rescue clause to handle downed site
    return {:results => [], :total => 0}
  end
  
  def self.build_tasks(id)
    task_items = []
    task_items << {:name => "Print and complete the FDIC Claimant Verification. Be sure to include your reference number: #{id}", :url => 'http://www2.fdic.gov/funds/claimform.htm'}
    task_items << {:name => 'Have the completed form notarized by a notary public.'}
    task_items << {:name => 'Mail completed, notarized form.'}
    task_items << {:name => 'You will be notified by an FDIC representative within 30 days of receipt of form.'}
    
    {:params => {:task => {:name => "Claim your money from FDIC, reference number: #{id}", :task_items_attributes => task_items}}}
  end
end

    
    