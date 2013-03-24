module InBloomHelper
  def href_for(item, rel)
    item.links.find {|item| item.rel == rel}.href
  end

  def in_bloom_link_to(caption, item, rel)
    link_to caption, href_for(item, rel)
  end
end
