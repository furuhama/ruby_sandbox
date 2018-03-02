#/usr/bin/env ruby

# N-Queen solver

# class Queen
#   attr_reader :col, :row

#   def initialize(col, row)
#     @col = col
#     @row = row
#   end
# end

# class Board
#   attr_reader :size
#   attr_accessor :board, :queens

#   def initialize(size=4)
#     @size = size
#     @board = Array.new(size, Array.new(size, true)) # @board[col][row]
#     @queens = []
#   end

#   def solver
#     # if next_step
#     #   return queens
#     # end

#     next_step
#   end

#   private

#   def next_step
#     if queens.length == size
#       return true
#     end

#     begin
#       search_column(queens.length)

#       latest_queen = queens[-1]
#       p latest_queen
#       update_board(latest_queen.col, latest_queen.row)
#       p board

#       # next_step
#     rescue
#       if queens.length == 0
#         return false
#       end

#       latest_queen = queens[-1]
#       board[latest_queen.col][latest_queen.row] = false

#       queens.delete_at(-1)

#       # next_step
#     end
#   end

#   def search_column(col_num)
#     (0..size).each do |row_num|
#       if board[col_num][row_num]
#         queens << Queen.new(col_num, row_num)

#         break
#       end

#       if row_num == size
#         raise 'there is no possibility'
#       end
#     end
#   end

#   def update_board(col_num, row_num)
#     # 横方向
#     # (col_num+1..size).each do |i|
#     #   board[i][row_num] = false
#     # end

#     # 右上方向
#     # (col_num+1..size).each do |i|
#     #   row_diff = i - col_num
#     #   if (row_num - row_diff) >= 0
#     #     board[i][(row_num - row_diff)] = false
#     #   else
#     #     break
#     #   end
#     # end

#     # 右下方向
#     # (col_num+1..size).each do |i|
#     #   row_diff = i - col_num
#     #   if (row_num + row_diff) > size - 1
#     #     board[i][(row_num + row_diff)] = false
#     #   else
#     #     break
#     #   end
#     # end

#     rest = size - 1 - col_num

#     # ここでうまくいってないっぽい
#     (1..rest+1).each do |i|
#       board[col_num+i][row_num] = false
#       if row_num - i >= 0
#         board[col_num+i][row_num-i] = false
#       end
#       if row_num + i < size
#         board[col_num+i][row_num+i] = false
#       end
#     end
#   end
# end

# if __FILE__ == $0
  # b = Board.new

  # b.solver
# end

# うまくいきそう

class NQueen
  def initialize(size = 4)
    @size = size
    @queens = []
  end

  def printer
    text = ""
    (0..@size-1).each do |col|
      (0..@size-1).each do |row|
        text += if @queens[row] == col
                  "Q "
                else
                  "_ "
                end
      end
      text += "\n"
    end
    puts text
  end
end

# main process
if __FILE__ == $0
  hoge = NQueen.new
  hoge.printer
end
