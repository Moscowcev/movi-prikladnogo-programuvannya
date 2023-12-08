class Heap

  attr_accessor :heap_length, :array_rep

  def initialize(array, length)
    @heap_length = array.length
    @array_rep = array
  end

  def left_child(index)
    2 * index + 1
  end

  def right_child(index)
    2 * index + 2
  end

  def left_child_key(index)
    @array_rep[left_child(index)]
  end

  def right_child_key(index)
    @array_rep[right_child(index)]
  end

  def leaf_node?(index)
    index >= @heap_length / 2
  end

  def satisfied?(index)
    @array_rep[index] >= left_child_key(index) and @array_rep[index] >= right_child_key(index)
  end

  def fix_one_error(index)
    return if leaf_node?(index) || satisfied?(index)
    left_child_key = @array_rep[left_child(index)]
    right_child_key = @array_rep[right_child(index)]
    larger_child = if left_child_key > right_child_key then left_child(index) else right_child(index) end
    @array_rep[index], @array_rep[larger_child] = @array_rep[larger_child], @array_rep[index]
    fix_one_error(larger_child)
  end

  def create_max_heap
    (0..@heap_length/2-1).to_a.reverse.each do |index|
      fix_one_error(index)
    end
  end

end

holder_arr = Array.new
holder_el = 0
puts "Amount of elements?"
size = gets.chomp.strip.to_i
while size < 1
  puts "Incorrect value."
  size = gets.chomp.strip.to_i
end
puts "Input array elements."
(1..size).each do
  holder_el = gets.chomp.strip.to_i
  holder_arr.push(holder_el)
end
puts "Starting array:"
puts holder_arr.to_s
some_heap = Heap.new(holder_arr, holder_arr.length)
some_heap.create_max_heap
puts some_heap.array_rep.to_s