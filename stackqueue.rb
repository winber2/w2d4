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
    if @store.empty?
      @store.push( { key: [el, el] } )
      return
    end

    last = @store.last[:key]
    if last[0] < el
      @store.push( { key: [el, last[1]] } )
    elsif last[1] > el
      @store.push( { key: [last[0], el] } )
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
        @queue.add(@stack.remove)
      end
    end

    @queue.remove
  end

  def empty?
    @stack.empty? && @queue.empty?
  end

end
