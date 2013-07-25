class CaUnclaimedProperty
  include Capybara::DSL

  attr_reader :results, :total
  
  def initialize(last_name, options = {})
    Capybara.run_server = false
    Capybara.current_driver = :webkit
    Capybara.app_host = "https://scoweb.sco.ca.gov/UCP/Default.aspx"

    visit('/UCP/Default.aspx')
    fill_in 'ctl00$ContentPlaceHolder1$txtLastName', :with => last_name
    find('input#ctl00_ContentPlaceHolder1_btnSearch').click
    
    raise "Error" unless page.current_path == "/ucp/SearchResults.aspx"
    
    if page.status_code == 200
      if first('td.dkBlueBarHeader14px').text == "UNCLAIMED PROPERTY SEARCH RESULTS NO MATCH"
        results = []
      else
        doc = Nokogiri::HTML(page.body)
        rows = doc.css('#ctl00_ContentPlaceHolder1_gvResults tr')[1..25]

        @results = []
                
        rows.map do |row|
          result = {}
          result[:name] = get_name(row)
          result[:address] = get_address(row)
          result[:city_state_zip] = get_city_state_zip(row)
          result[:id] = get_id(row)
          result[:type] = get_type(row)

          @results << result
          @total = @results.count
        end
      
      end # end if first(...)
#      return {:results => results, :total => results.size}
    end # end if page.status.code == 200
    rescue
      return @results = [] && @total = 0
    
  end # end initialize
  
  def get_name(row)
    return nil unless row
    name_items = row.css('td')[0].text.titleize.split
    case
    when name_items.count > 2
      name = "#{name_items[0]}, #{name_items[1]} #{name_items[2]}"
    when name_items.count == 2
      name = "#{name_items[0]}, #{name_items[1]}"
    else name_items.count < 2
      name = "#{name_items[0]}"
    end
    
    name
  end

  def get_address(row)
    return nil unless row
    row.css('td')[1].text.strip.squish.titleize.gsub('Po Box', 'PO Box')
  end

  def get_city_state_zip(row)
    return nil unless row.css('td')[2]
    row.css('td')[2].inner_html.squish
  end
  
  def get_city_state_zip2(row)
    state_codes = ["AA", "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    
    city_items = row.css('td')[2].text.split
    
    size = city_items.count
    case
    when size > 2
      city_info = "#{city_items[0..(size-3)]}, #{city_items[size-2]} #{city_items[size-1]}"
    when size == 2
      city_info = "#{city_items[0]}, #{city_items[1]}"
    else size < 2
      city_info = "#{city_items[0]}"
    end
  end

  def get_id(row)
    return nil unless row.css('td')[3]
    row.css('td')[3].inner_html
  end
  
  def get_type(row)
    return nil unless row.css('td')[4]
    row.css('td')[4].inner_html.scan(/(\w)Icon/).join.capitalize
  end
  
end
