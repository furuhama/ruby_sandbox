# Pattern route

class PatternRoute
  attr_reader :pattern, :size

  def initialize(pattern)
    @pattern = pattern
    @size = pattern.length
  end

  def check_route
    (0..size-1).each do |i|
      if check_next(i) == 0
        p 'failure'
      end
    end
  end

  def check_next(index)
    tmp = pattern[index].clone
    pattern[index] = 0
    return tmp
  end
end

if __FILE__ == $0
  p = PatternRoute.new([1, 2, 3, 4, 5, 6, 7])

  p.check_route
end
