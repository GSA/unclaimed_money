class HudSearch
  DEFAULT_PARAMS = {:case_num => "", :idx => "0", :rangestart => "1", :recordcount => "0", :rangeend => "0", :groupsize => "30", :called_from => "page1", :search => "Search"}
  FIELDS = ["name", "address", "city", "state", "zip", "case_number", "other_number"]
  
  def self.search_for(last_name, options = {})
    response = HTTParty.post("http://www.hud.gov/offices/hsg/comp/refunds/refundlist.cfm", {:body => DEFAULT_PARAMS.merge(:f_name => last_name)})
    if response.code == 200
      if response.body =~ /No Match Found/
        results = []
      else
        results = []
        doc = Nokogiri::HTML(response.body)
        doc.xpath("//table[@width='600']/tr").each_with_index do |row, index|
          if index % 2 == 1
            next
          else
            result = {}
            result[:name] = row.xpath("td").first.xpath("font").text.strip.squish.titleize
            result[:address] = row.xpath("td")[1].xpath("font").inner_html.split("<br>").first.titleize
            result[:city] = row.xpath("td")[1].xpath("font").inner_html.split("<br>").last.titleize
            result[:case_number] = row.xpath("td")[2].xpath("font").inner_html.split("<br>").first
            result[:state] = row.xpath("td")[2].xpath("font").inner_html.split("<br>").last.split(" ").first
            result[:zip] = row.xpath("td")[2].xpath("font").inner_html.split("<br>").last.split(" ").last
            result[:claim_date] = row.xpath("td").last.xpath("font").inner_html.split("<br>").first
            result[:other_number] = row.xpath("td").last.xpath("font").inner_html.split("<br>").last
            results << result
          end
        end
      end
      return {:results => results, :total => results.size}
    end
    rescue # generic rescue clause to handle downed site
      return {:results => [], :total => 0}
  end
  
  def self.build_tasks(id)
    task_items = []
    task_items << {:name => "Call HUD at 1-800-697-6967 or contact them by postal mail."}
    task_items << {:name => 'Get more information about refunds, read the Fact Sheet.', url: 'http://www.hud.gov/offices/hsg/comp/refunds/fhafact.cfm'}
    
    {:params => {:task => {:name => "Claim your money from HUD, case number #{id}", :task_items_attributes => task_items}}}
  end
  
end

    
