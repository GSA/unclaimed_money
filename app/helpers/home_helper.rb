module HomeHelper

  def ca_result_type(type)
    case
    when type == "P"
      content_tag :span, 'P', class: "has-tip tip-left", title: "These are properties sent to the State for safekeeping as required by law. These properties may be claimed through the process outlined on our website. Click on the link in the ID Number column to see the Property Details and access the Claim Form.", "data-tooltip" => nil, "data-width" => 300
    when type == "N"
      content_tag :span, 'N', class: "has-tip tip-left", title: "These are properties still in the possession of the business that will be sent to the State for safekeeping unless the owner contacts the business to recover the property or reactivate the account within the timeframe indicated in the Notice Details. You may contact the business to reactivate or recover the account free of charge. Click on the 'Details' link in the ID Number column to get the Business' Contact Information. Investigators are not allowed to contract with a property owner to help the owner recover properties that a business has reported to the state but the state has yet to receive.", "data-tooltip" => nil, "data-width" => 300
    when type == "I"
      content_tag :span, 'I', class: "has-tip tip-left", title: "These are properties that the business is required to transfer to the State because the owner did not contact the business to recover the property or reactivate the account within the required timeframe. These properties are currently unavailable to be claimed as they are in the process of transferring to the State. When the property is available to be claimed, the 'I' will be replaced with a 'P'. Click on the 'Details' link in the ID Number column to find out more about the 'Interim Details' property.", "data-tooltip" => nil, "data-width" => 300
    end
  end

end
