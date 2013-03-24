module InBloomHelper
  def in_bloom_link_to(caption, item, rel)
    link_to caption, href_for(item, rel)
  end

  def full_name(item_with_name)
    name_node = item_with_name.name
    full_name = name_node.lastSurname
    if first_name = name_node.firstName
      full_name += ", #{first_name}"
    end
    full_name
  end
end
