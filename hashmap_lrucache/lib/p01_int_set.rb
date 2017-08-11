require 'byebug'

class MaxIntSet
  attr_reader :max
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num] == true

    false
  end

  private

  def is_valid?(num)
    return false if num > (max - 1) || num < 0

    true
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :num_buckets
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  # def [](num)
  #   @store[num % num_buckets]
  # end

  def num_buckets
    @store.length
  end
end


class ResizingIntSet
  attr_reader :count
  attr_accessor :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if include?(num) == false
      @store[num % num_buckets] << num
      @count += 1
    end

    if @count == num_buckets
      resize!
    end
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end

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
