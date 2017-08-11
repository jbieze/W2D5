require_relative 'p02_hashing'

class HashSet
  attr_reader :count
  attr_accessor :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    hash = hash!(key)
    @store[hash % num_buckets] << key
    @count += 1
    if @count == num_buckets
      resize!
    end
  end

  def include?(key)
    hash = hash!(key)
    @store[hash % num_buckets].include?(key)
  end

  def remove(key)
    hash = hash!(key)
    @store[hash % num_buckets].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def hash!(el)
    el.hash
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets = count * 2
    previous = @store
    @store = Array.new(@num_buckets) {Array.new}
    @count = 0
    previous.each do |buckets|
      buckets.each do |el|
        self.insert(el)
      end
    end
  end

end

# class ResizingIntSet
#
#
#
#   def insert(num)
#     if include?(num) == false
#       @store[num % num_buckets] << num
#       @count += 1
#     end
#
#     if @count == num_buckets
#       resize!
#     end
#   end
#
#   def remove(num)
#     @store[num % num_buckets].delete(num)
#   end
#
#   def include?(num)
#     @store[num % num_buckets].include?(num)
#   end
# end
