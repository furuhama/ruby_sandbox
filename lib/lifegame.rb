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

  def print_times(time)
    time.times do
      printer
      printf "\e[#{size}A"
      self.next
      sleep 0.1
    end
  end

  def printer
    lifegame = ""
    (0..size-1).each do |col|
      (0..size-1).each do |row|
        if lifes[col][row] == 1
          lifegame += "\e[32m■\e[0m " # this means green color square
        else
          lifegame += "□ "
        end
      end
      lifegame += "\n"
    end

    printf lifegame
  end

  def next
    (0..size-1).each do |col|
      (0..size-1).each do |row|
        next_life(col, row)
      end
    end

    @lifes = Marshal.load(Marshal.dump(next_lifes))
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
  lg = Lifegame.new(40)

  # make glider
  lg.lifes[4][4] = 1
  lg.lifes[4][5] = 1
  lg.lifes[4][6] = 1
  lg.lifes[5][4] = 1
  lg.lifes[6][5] = 1

  lg.print_times 200
end
