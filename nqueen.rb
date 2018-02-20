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
  attr_accessor :board, :queens

  def initialize(size=4)
    @size = size
    @board = Array.new(size, Array.new(size, true)) # @board[col][row]
    @queens = []
  end

  def solver
  end

  private

  def search_column(col_num)
    for row in size
      if board[col_num][row]
        queens << [col_num, row]

        break
      end

      if row == size
        raise 'there is no possibility'
      end
    end
  end

  def update(col_num, row_num)
    # 横方向
    (col_num+1..size).each do |i|
      board[i][row_num] = false
    end

    # 右上方向
    (col_num+1..size).each do |i|
      row_diff = i - col_num
      if row_num - row_diff >= 0
        board[i][row_num - row_diff] = false
      else
        break
      end
    end

    # 右下方向
    (col_num+1..size).each do |i|
      row_diff = i - col_num
      if row_num + row_diff > size - 1
        board[i][row_num + row_diff] = false
      else
        break
      end
    end
  end
end

# main process
if __FILE__ == $0
  q = Queen.new(2, 3)
  p q

  b = Board.new
  p b
end
