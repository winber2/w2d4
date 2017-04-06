require 'benchmark'

def bad_min(arr)
  tracker = false
  arr.each do |el|
    arr2 = arr - [el]
    tracker = arr2.all? do |el2|
      el < el2
    end
    return el if tracker
  end
end

def my_min(arr)
  min = arr.first
  arr.drop(1).each do |el|
    min = el if el < min
  end
  min
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
puts "Benchmark array minimums"
puts Benchmark.measure { bad_min(list) }
puts Benchmark.measure { my_min(list) }

def bad_sub_sum(arr)
  subarrays = []
  1.upto(arr.length - 1) do |i|
    arr.each_cons(i) {|sub_arr| subarrays << sub_arr }
  end
  subarrays.sort_by {|sub| sub.reduce(:+)}.last.reduce(:+)
end

def largest_continuos_subsum(arr)
  biggest_sum = arr.first
  sum = arr.first
  arr.each do |el|
    sum = 0 if sum < 0
    sum += el
    biggest_sum = sum if sum > biggest_sum
  end

  biggest_sum
end

def largest_contiguous_subsum2(arr)
  largest = arr.first
  current = arr.first

  return arr.max if arr.all? { |num| num < 0 }

  arr.drop(1).each do |num|
    current = 0 if current < 0
    current += num
    largest = current if current > largest
  end

  largest
end

list = [2, 3, -6, 7, -6, 7]
puts "Benchmark contiguous sums"
puts Benchmark.measure { largest_continuos_subsum(list) }
puts Benchmark.measure { largest_contiguous_subsum2(list) }
