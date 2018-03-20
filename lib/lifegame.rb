# Conway's Lifegame

class Lifegame
  attr_reader :lifes, :next_lifes, :size

  def initialize(size = 8)
    @size = size
    @lifes = []
    @next_lifes = []

    size.times do
      lifes << Array.new(size, 0)
      next_lifes << Array.new(size, 0)
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

  def next_life(col, row)
    if lifes[col][row] == 1
      if (count_surround_lives(col, row) == 2) || (count_surround_lives(col, row) == 3)
        next_lifes[col][row] = 1
      else
        next_lifes[col][row] = 0
      end
    else
      if count_surround_lives(col, row) == 3
        next_lifes[col][row] = 1
      else
        next_lifes[col][row] = 0
      end
    end
  end

  def count_surround_lives(col, row)
    count = 0

    (col-1..col+1).each do |col_num|
      (row-1..row+1).each do |row_num|
        # to think of corner cases,
        # not to use col_num & row_num directly
        # use the reminder of lifegame size
        next if col_num%size == col && row_num%size == row
        count += lifes[col_num%size][row_num%size]
      end
    end

    count
  end
end

if __FILE__ == $0
  lg = Lifegame.new
  p lg.lifes
  lg.lifes[0, 1] = 1
  lg.lifes[1, 0] = 1
  p 'count', lg.count_surround_lives(0, 0)
  lg.next_life(0, 0)
end
