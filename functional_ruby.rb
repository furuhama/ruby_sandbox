#/usr/bin/env ruby

add_10 = lambda { |x| x + 10 }
# same sematics notation
# add_10 = ->(x){ x + 10 }

if __FILE__ == $0
  p add_10.call 4
end
