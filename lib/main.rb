require_relative 'tree'

test = Tree.new((Array.new(15) { rand(1..100) }))

test.pretty_print
puts test.balanced?
print test.level_order
puts
print test.inorder
puts
print test.preorder
puts
print test.postorder
puts
test.insert(110)
test.insert(200)
test.insert(105)
test.pretty_print
puts test.balanced?
test.rebalance
puts
test.pretty_print
puts test.balanced?