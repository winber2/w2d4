require_relative 'stackqueue'
require 'byebug'

def windowed_max_range(arr, window)
  max_win = arr.min
  arr.each_cons(window) { |win|
      check = win.max - win.min
      max_win = check if check > max_win
  }
  max_win
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

def windowed_max_range_stack(arr, window)
  stack_q = MinMaxStackQueue.new
  0.upto(window - 1) do |i|
    p "#{stack_q}   ===== #{i} === #{arr[i]}"
    stack_q.enqueue(arr[i])
  end
  max_window = 0
  # max = stack_q.max
  # min = stack_q.min
  i = 0
  while i + window < arr.length
    new_max_w = stack_q.peek.reduce(:-)
    max_window = max_window > new_max_w ? max_window : new_max_w
    stack_q.dequeue
    # max = stack_q.max if stack_q.max > max
    # min = stack_q.min if stack_q.min < min
    stack_q.enqueue(arr[i + window])
    i += 1
  end
  new_max_w
end

p windowed_max_range_stack([1, 0, 2, 5, 4, 8], 3)
