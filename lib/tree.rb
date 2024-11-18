# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr, start = 0, end_index = arr.length - 1)
    return nil if start > end_index

    mid = (start + end_index) / 2
    curr_root = Node.new(arr[mid])
    curr_root.left = build_tree(arr, start, mid - 1)
    curr_root.right = build_tree(arr, mid + 1, end_index)
    curr_root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    return root if root.value == value

    if value < root.value
      root.left = insert(value, root.left)
    else
      root.right = insert(value, root.right)
    end
    root
  end

  def delete(value, root = @root)
    return nil if root.nil?

    if value < root.value
      root.left = delete(value, root.left)
    elsif value > root.value
      root.right = delete(value, root.right)
    elsif root.left.nil? && root.right.nil?
      return nil
    elsif root.left.nil?
      root = root.right
    elsif root.right.nil?
      root = root.left
    else
      sub_tree_min = min_value(root.right)
      root.value = sub_tree_min.value
      root.right = delete(sub_tree_min.value, root.right)
    end
    root
  end

  def min_value(curr_node)
    curr_node = curr_node.left until curr_node.left.nil?
    curr_node
  end

  def find(value, root = @root)
    return nil if root.nil?

    if value < root.value
      root.left = find(value, root.left)
    elsif value > root.value
      root.right = find(value, root.right)
    else
      root
    end
  end

  def level_order
    return nil if root.nil?

    queue = []
    result = []
    queue.prepend(root)
    until queue.empty?
      curr_node = queue[-1]
      curr_node.value = yield curr_node.value if block_given?
      result.push(curr_node.value)
      queue.prepend(curr_node.left) unless curr_node.left.nil?
      queue.prepend(curr_node.right) unless curr_node.right.nil?
      queue.pop
    end
    result
  end

  def preorder(root = @root, arr = [])
    return nil if root.nil?

    yield root.value if block_given?
    arr.push(root.value)
    preorder(root.left, arr)
    preorder(root.right, arr)
    arr
  end

  def inorder(root = @root, arr = [])
    return nil if root.nil?

    inorder(root.left, arr)
    yield root.value if block_given?
    arr.push(root.value)
    inorder(root.right, arr)
    arr
  end

  def postorder(root =  @root, arr = [])
    return nil if root.nil?

    postorder(root.left, arr)
    postorder(root.right, arr)
    yield root.value if block_given?
    arr.push(root.value)
    arr
  end
end

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

test.pretty_print

print test.preorder
print test.inorder
print test.postorder