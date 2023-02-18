class Node
  attr_reader :display,
              :empty,
              :ne,
              :e,
              :se,
              :s,
              :sw,
              :w,
              :nw
              
  def initialize(col, row, board)
    @display = '.'
    @empty = (@display == '.')
    @ne = board[col+1][row+1]
    @e  = board[col+1][row]
    @se = board[col+1][row-1]
    @s  = board[col][row-1]
    @sw = board[col-1][row-1]
    @w  = board[col-1][row]
    @nw = board[col-1][row+1]
    @compass = [ne, e, se, s, sw, w, nw]
  end

  def connect?(number = 4, letter = self.display, count = 1)
    starting_node, node = self, self
    @compass.each do |direction|
      until node.direction.nil? || node.direction.display != letter
        return true if (count += 1) == number
        node = node.direction
      count = 1
      node = starting_node
      connect = false
    end
  end

  def connect(letter = self.display)
    starting_node, node = self, self
    @compass.map {  |direction|
      count = 1
      node = starting_node
      until node.direction.nil? || node.direction.display != letter
        count += 1
        node = node.direction
      count
    }.max
  end
end
  # node.connect? / node.connect?(4) / node.connect('X') == 4 all say 
  # the same thing. the methods are redundant for the basic game but
  # both might be useful for the different return types if we go deeper