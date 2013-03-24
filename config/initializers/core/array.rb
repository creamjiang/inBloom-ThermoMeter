Array.class_eval do
  def mean
    empty? ? 0 : sum / size
  end

  def sum
    inject(:+)
  end
end
