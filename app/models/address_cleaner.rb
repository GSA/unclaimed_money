class AddressCleaner
  require 'indirizzo'

  def self.parse(unformatted_address)
    return nil if unformatted_address.nil? || unformatted_address.blank?
    location = Indirizzo::Address.new(unformatted_address.squish, expand_streets: false)

    street = location.street[0].titleize unless location.street[0].nil?
    
    if street
      # join Apt line2
      if location.street[1] && location.street[1].match(/apt|lot/)
        street += " #{location.street[1].titleize}"
      end

      # restore number's with -<letter> (e.g. 3104-B)
      if letter = location.text.match(/^\d+(-[a-zA-Z])/)
        street.sub(/^(\d+)/, letter[1]) 
      end
      # add pound sign back to Apt/PO Box numbers
      street.sub!(/(\d+)$/, '#\1')
      # handle case where Apt number is a letter
      
      # fix Se,Sw,Ne,Nw starting in street names
      
      # clean up PO Box
      street.sub!('P O Box', 'PO Box')
    end
    
    city = location.city[0].titleize if location.city[0]
    
    formatted_location = "#{location.number} #{street}, #{city}, #{location.state} #{location.zip}#{'-' + location.plus4 unless location.plus4.nil? || location.plus4.blank? }".squish
    
    formatted_location = '' if formatted_location.include?("None") or !formatted_location.match(/[a-zA-Z]+/)
    return formatted_location
  end

end
