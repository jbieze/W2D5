class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    new_arr = []
    return nil.hash if self.empty?

    self.each_with_index do |el, ind|
      new_arr << el.hash + ind.hash
    end
    new_arr.inject(:*)

  end
end

class String
  def hash
    self.chars.map{ |char| char.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.map {|k,v| [k,v]}.sort.hash
     #0
  end
end
