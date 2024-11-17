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
end

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

test.pretty_print



test.insert(10)

test.pretty_print
