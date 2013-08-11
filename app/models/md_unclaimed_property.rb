class MdUnclaimedProperty
  include Capybara::DSL
  attr_reader :results, :total
  
  def initialize(last_name, options = {})
    Capybara.run_server = false
    Capybara.current_driver = :webkit
    Capybara.app_host = "https://interactive.marylandtaxes.com"

    visit('/individuals/unclaim/default.aspx')
    fill_in 'txtLName', :with => last_name
    find('input#btnSearch').click

    raise "Error" unless page.current_path == "/individuals/unclaim/user/iuu_unclaim_f.aspx"

    if page.status_code == 200
      # need to change this for MD
      if page.text.include? "Your search has returned no matching records at this time"
        @results = []
        @total = 0
      else
        doc = Nokogiri::HTML(page.body)
        rows = doc.css('#dgUnclaimedPR tbody tr')[1..25]

        @results = []

        rows.map do |row|
          next unless row.css('td').count == 5
          
          result = {}
          result[:claim] = get_claim(row)
          result[:name] = get_name(row)
          result[:address] = get_address(row)

          @results << result
          @total = @results.count
        end
      end # end if first(...)
    end # end if page.status.code == 200
    rescue # generic rescue clause to handle downed site
      @results = nil
      @total = 0
  end
  
  def get_claim(row)
    return nil unless row
    row.css('td')[0].inner_html
  end

  def get_name(row)
    return nil unless row
    last_name = row.css('td')[1].inner_html.squish
    first_name = row.css('td')[2].inner_html.squish
    middle_initial = row.css('td')[3].inner_html.squish
    
    name = "#{last_name + ", " if last_name}#{first_name}#{" " + middle_initial if middle_initial}".gsub('&amp;', '&').titleize.html_safe
  end

  def get_address(row)
    return nil unless row
    row.css('td')[4].text.strip.squish.titleize
  end

  def self.build_tasks(id)
    task_items = []
    task_items << {:name => "Print and complete claim form ST-912. Be sure to indicate you claim number.", :url => 'http://comptroller.marylandtaxes.com/Public_Services/Unclaimed_Property/static_files/COT-ST912.pdf'}
    task_items << {:name => "Mail the completed and signed Claim Affirmation Form to the Comptroller's Office."}
    
    {:params => {:task => {:name => "Claim your money from MD, Property ID Number: #{id}", :task_items_attributes => task_items}}}
  end
end
