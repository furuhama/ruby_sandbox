#/usr/bin/env ruby

#
# lambda
#

add_10 = lambda { |x| x + 10 }
# same sematics notation
# add_10 = ->(x){ x + 10 }

#
# proc
#

add_5 = proc { |x| x + 5 }
# same sematics notation
# add_5 = Proc.new { |x| x + 5 }

#
# Symbol#to_proc
#

def use_to_proc
  [1, 2, 3, 4, 5].map &:even?
end

# &:to_s
# is essentially the same as
# proc do |obj|
#   obj.to_s
# end

class MyCollection
  def initialize(items)
    @collection = items
  end

  def map(fn)
    saved = []
    @collection.each do |item|
      saved << fn.call(item)
    end
    MyCollection.new(saved)
  end
end

if __FILE__ == $0
  p add_10.call 4

  p add_5.call 10

  p use_to_proc

  my_col = MyCollection.new([1, 2, 3])
  my_col = my_col.map(add_10)

  p my_col
end
