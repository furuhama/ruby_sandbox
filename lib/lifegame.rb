# Conway's Lifegame

class Lifegame
  attr_reader :lifes

  def initialize(size = 8)
    @size = size
    @lifes = []

    size.times do
      @lifes << Array.new(size, 0)
    end
    # board definition
    #
    # @lifes[col][row]
    # [
    #   [0, 0, ... 0],
    #   [0, 0, ... 0],
    #       ...
    #       ...
    #   [0, 0, ... 0]
    # ]
  end

  def next_gen(row, col)
  end
end

if __FILE__ == $0
  lg = Lifegame.new
  p lg.lifes
end
