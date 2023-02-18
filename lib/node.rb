class Node
  attr_reader :display,
              :empty,
              :board,
              :ne,
              :e,
              :se,
              :s,
              :sw,
              :w,
              :nw
              
  def initialize(column, row, board)
    @display = '.'
    @empty = (@display == '.')
    @board = board
    @ne = board[column+1][row+1]
    @e = board[column+1][row]
    @se = board[column+1][row-1]
    @s = board[column][row-1]
    @sw = board[column-1][row-1]
    @w = board[column-1][row]
    @nw = board[column-1][row+1]
    @directions = [ne, e, se, s, sw, w, nw]
  end

  def connect?(number, letter, count = 1)
    starting_node, node = self, self
    @directions.each do |direction|
      until node.direction.nil? || node.direction.display != letter
        count += 1
        node = node.direction
        return true if count == number
      count = 1
      node = starting_node
      connect = false
    end
  end

  def connect(letter)
    starting_node, node = self, self
    @directions.map {  |direction|
      count = 1
      node = starting_node
      until node.direction.nil? || node.direction.display != letter
        count += 1
        node = node.direction
      count
    }.max
  end
end