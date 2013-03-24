module InBloomHelper
  def in_bloom_link_to(caption, item, rel)
    link_to caption, href_for(item, rel)
  end
end
