#/usr/bin/env ruby

# N-Queen solver

class Queen
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Board
  attr_reader :size

  def initialize(size=8)
    @size = size
  end
end

if __FILE__ == $0
  q = Queen.new(2, 3)
  p q

  b = Board.new
  p b
end
