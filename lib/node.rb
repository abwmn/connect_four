class Node
  attr_reader :display, :empty, :ne, :e, :se, :s, :sw, :w, :nw
              
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
    @compass = { ne: sw, e: w, se: nw, s: nil }
  end

  #recursive
  def count_connections(direction, letter, count = 0)
    next_node = self.direction
    return count if next_node.nil? || next_node.display != letter
    next_node.count_connections(direction, letter, count + 1) 
  end

  # iterative
  # def count_connections(direction, letter)
  #   count = 0
  #   node = self
  #   while node && node.direction && node.direction.display == letter
  #     node = node.direction
  #     count += 1
  #   end
  #   count
  # end

  def connect(letter = @display)
    max_count = 0
    @compass.each do |direction, opposite|
      count = count_connections(direction, letter)
      opposite_count = count_connections(opposite, letter)
      total_count = count + opposite_count + 1
      max_count = [max_count, total_count].max
    end
    max_count
  end

  def connect?(length = 4, letter = @display)
    connect(letter) >= length
  end
end



  # def connect?(number = 4, letter = self.display, count = 1)
  #   starting_node, node = self, self
  #   @compass.each do |direction|
  #     until node.direction.nil? || node.direction.display != letter
  #       return true if (count += 1) == number
  #       node = node.direction
  #     count = 1
  #     node = starting_node
  #     connect = false
  #   end
  # end

  # def connect(letter = self.display)
  #   starting_node, node = self, self
  #   @compass.map {  |direction|
  #     count = 1
  #     node = starting_node
  #     until node.direction.nil? || node.direction.display != letter
  #       count += 1
  #       node = node.direction
  #     count
  #   }.max
  # end

  # node.connect? / node.connect?(4) / node.connect('X') == 4 all say 
  # the same thing. the methods are redundant for the basic game but
  # both might be useful for the different return types if we go deeper

  # these can be refactored with a shared helper method for 
  # finding connection length in a single direction:

  # def count_connections(letter, direction)
  #   count = 0
  #   node = self
  
  #   until node.nil? || node.display != letter
  #     count += 1
  #     node = node.direction
  #   end
  
  #   count
  # end
  
  # def connect?(number = 4, letter = self.display)
  #   @compass.any? { |direction| count_connections(letter, direction) >= number }
  # end
  
  # def connect(letter = self.display)
  #   @compass.map { |direction| count_connections(letter, direction) }.max
  # end

  # ^ thanks, chatGPT. you have to ask it the right questions, 
  # and verify/modify as necessary, and it'll show you good stuff

  # after realizing we need to count two directions at once and 
  # making sure chatGPT understood this, found a good solution, replacing above
  
  
  
  
  
  