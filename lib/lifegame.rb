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

  def set_template(name)
    case name
    when 'glider'
      if size < 7
        puts 'size is not enough'
        return
      end

      # make glider
      lifes[1][4] = 1
      lifes[4][5] = 1
      lifes[4][6] = 1
      lifes[5][4] = 1
      lifes[6][5] = 1

    when 'glider-gun'
      if size < 40
        puts 'size is not enough'
        return
      end

      # make glider gun
      lifes[1][27] = 1
      lifes[2][27] = 1
      lifes[2][25] = 1
      lifes[3][24] = 1
      lifes[3][23] = 1
      lifes[4][24] = 1
      lifes[4][23] = 1
      lifes[5][24] = 1
      lifes[5][23] = 1
      lifes[6][25] = 1
      lifes[6][27] = 1
      lifes[7][27] = 1

      lifes[3][37] = 1
      lifes[3][38] = 1
      lifes[4][37] = 1
      lifes[4][38] = 1

      lifes[3][15] = 1
      lifes[3][16] = 1
      lifes[4][14] = 1
      lifes[4][18] = 1
      lifes[5][13] = 1
      lifes[5][19] = 1
      lifes[6][13] = 1
      lifes[6][17] = 1
      lifes[6][19] = 1
      lifes[6][20] = 1
      lifes[7][13] = 1
      lifes[7][19] = 1
      lifes[8][14] = 1
      lifes[8][18] = 1
      lifes[9][15] = 1
      lifes[9][16] = 1

      lifes[5][3] = 1
      lifes[5][4] = 1
      lifes[6][3] = 1
      lifes[6][4] = 1
    else
      puts 'unknown argument...'
    end
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

  lg.set_template 'glider-gun'

  lg.print_times 200
end
