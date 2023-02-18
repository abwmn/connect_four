class Node
  attr_reader :letter, :empty, :ne, :e, :se, :s, :sw, :w, :nw
              
  def initialize(col, row, board)
    @letter = '.'
    @empty = (@letter == '.')
    @ne = board[col+1][row+1]
    @e  = board[col+1][row]
    @se = board[col+1][row-1]
    @s  = board[col][row-1]
    @sw = board[col-1][row-1]
    @w  = board[col-1][row]
    @nw = board[col-1][row+1]
    @compass = { ne: sw, e: w, se: nw, s: nil }
  end

  def count(direction, letter, count = 0)
    node = self
    return count unless node&.direction&.letter == letter
    node.direction.count(direction, letter, count + 1) 
  end

  def connect(letter = @letter)
    connex = 0
    @compass.each do |forth, back|
      to = count(forth, letter)
      fro = count(back, letter)
      total = to + fro + 1
      connex = [total, connex].max
    end
    connex
  end

  def connect?(length = 4, letter = @letter)
    connex(letter) >= length
  end
end