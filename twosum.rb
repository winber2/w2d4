require 'benchmark'

def bad_two_sum?(arr, target)
  (0...arr.length).each do |i|
    (i + 1...arr.length).each do |j|
      return true if arr[i] + arr[j] == target
    end
  end
  false
end

def okay_two_sum?(arr, target)
  arr = arr.sort
  length = arr.length
  i = 1
  arr.any? do |el| #n
    arr[i...length].bsearch do |x|
      x == target - el #log(n)
    end
    i += 1
  end
end


def hash_sum?(arr, target)
    hash = Hash.new
    arr.each {|el| hash[target - el] = el}
    arr.any? {|el| hash[el]}
end


arr = (1..2_500_000).to_a.shuffle + (1..2_500_000).to_a.shuffle
target = 128573
puts Benchmark.measure { bad_two_sum?(arr, target) }
puts Benchmark.measure { okay_two_sum?(arr, target) }
puts Benchmark.measure { hash_sum?(arr, target) }
puts okay_two_sum?([1,2,3,3,3,4,3,4,5], 7)
puts hash_sum?([1,2,3,3,3,4,3,4,5], 7)
