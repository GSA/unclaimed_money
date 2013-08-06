class PbgcSearch
  DEFAULT_PARAMS = {:commandAction => "indvSearch1", :wc1 => "exact", :company1 => "", :wc2 => "contains", :state1 => "0"} 
  
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
            result[:company] = row.xpath("td").first.text.squish.titleize
            result[:last_known_address] = AddressCleaner.parse(row.xpath("td").last.text)

            results << result
          end
        end
      end
      return {:results => results, :total => results.size}
    end
    rescue # generic rescue clause to handle downed site
      return {:results => [], :total => 0}
  end
  
  def self.build_tasks(url)
    task_items = []
    task_items << {:name => "Call PBGC toll-free at 1-800-326-LOST or fill out the secure form.", url: url}
    task_items << {:name => 'Get more information about refunds with the Fact Sheet.', url: 'http://www.pbgc.gov/res/factsheets/page/missing-participant-program.html'}
    
    {:params => {:task => {:name => "Claim your money from PBGC", :task_items_attributes => task_items}}}
  end

end
