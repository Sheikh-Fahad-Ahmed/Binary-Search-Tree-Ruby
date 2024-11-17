require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort)
  end

  def build_tree(arr)
    
  end
end