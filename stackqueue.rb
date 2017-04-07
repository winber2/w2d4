class MyStack
  attr_reader :store

  def initialize
    @store = []
  end

  def add(el)
    @store.push(el)
    el
  end

  def remove
    @store.pop
  end

  def peek
    @store.last
  end

  def empty?
    @store.empty?
  end
end

class MinMaxStack < MyStack
  attr_reader :store, :max

  def initialize
    @store = []
  end

  def add(el)
    if el.is_a?(Hash)
      @store.push(el)
      return
    end

    if @store.empty?
      # update if key already exists
      @store.push( { el => [el, el] } )
      return
    end

    last = @store.last[el]
    if last[0] < el
      @store.push( { el => [el, last[1]] } )
    elsif last[1] > el
      @store.push( { el => [last[0], el] } )
    else
      @store.push(@store.last)
    end
  end

  def remove
    @store.pop
  end

  def max
    @store.last[:key][0]
  end

  def min
    @store.last[:key][1]
  end
end


class StackQueue
  attr_reader :stack, :queue

  def initialize
    @stack = MyStack.new
    @queue = MyStack.new
  end

  def enqueue(el)
    if @stack.empty?
      until @queue.empty?
        @stack.add(@queue.remove)
      end
    end

    @stack.add(el)
  end

  def dequeue
    if @queue.empty?
      until @stack.empty?
        @queue.add(@stack.remove.key)
      end
    end

    @queue.remove
  end

  def empty?
    @stack.empty? && @queue.empty?
  end

end

class MinMaxStackQueue < MinMaxStack
  attr_reader :stack, :queue

  def initialize
    @stack = MinMaxStack.new
    @queue = MyStack.new
  end

  def enqueue(el)
    @stack.add(el)
  end

  def dequeue
    until @stack.empty?
      @queue.add(@stack.remove)
    end
    @queue.remove

    until @queue.empty?
      @stack.add(@queue.remove)
    end

    p "Shuffled correctly!"
  end

  def empty?
    @stack.empty? && @queue.empty?
  end

  def max
    @stack.max
  end

  def min
    @stack.min
  end

  def peek
    @stack.store.last
  end

end
