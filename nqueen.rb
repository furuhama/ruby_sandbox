#/usr/bin/env ruby

class NQueen
  def initialize(size = 4)
    @size = size
    @queens = []
  end

  def printer
    @queens.each do |queen|
      text = ""
      (0..@size-1).each do |col|
        (0..@size-1).each do |row|
          text += if queen[row] == col
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

  def solver
    generator

    # p @queens.select { |arr| checker(arr) }
    p @queens.select! { |arr| arr[0] == 1 }
  end

  def generator
    def permutator(unused, used)
      unless unused.empty?
        for e in unused
          used_clone = used.clone
          used_clone << e

          unused_clone = unused.clone
          unused_clone.delete(e)

          permutator(unused_clone, used_clone)
        end
      else
        @queens << used
      end
    end
    permutator((0..@size-1).to_a, [])
  end

  def checker(board)
    (0..@size-2).each do |element|
      for pair in (element+1..@size-1)
        if (board[element] - board[pair]).abs == element - pair
          return false
        end
      end
    end
    return true
  end
end

# main process
if __FILE__ == $0
  NQueen.new.solver
end
