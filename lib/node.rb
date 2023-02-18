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
              
  def initialize(column, row)
    @display = '.'
    @empty = (@display == '.')
    # @column = column
    # @row = row
    @directions = [ne, e, se, s, sw, w, nw]
    @ne = @board[column+1][row+1]
    @e = @board[column+1][row]
    @se = @board[column+1][row-1]
    @s = @board[column][row-1]
    @sw = @board[column-1][row-1]
    @w = @board[column-1][row]
    @nw = @board[column-1][row+1]
  end
  
  def connect?(number, letter)
    count = 1
    starting_node, node = self
    @directions.each do |direction|
      until node.direction.display != letter
        count += 1
        node = node.direction
      if count == number
        return true
      else 
        count = 1
        node = starting_node
        connect = false
      end
    end
  end

  def connect(letter)
    starting_node, node = self
    directions.map {  |direction|
      node = starting_node
      count = 1
      until node.direction.display != letter
        count += 1
        node = node.direction
      count
    }.max
  end
end