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

  #recursive
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

#########################

# iterative
  # def count_connections(direction, letter)
  #   count = 0
  #   node = self
  #   while node && node.direction && node.direction.letter == letter
  #     node = node.direction
  #     count += 1
  #   end
  #   count
  # end

#iterative v2
 # def count_connections(direction, letter)
  #   count = 0
  #   node = self
  #   while (node = node.direction)
  #     if node.letter == letter
  #       count += 1
  #     else
  #       break
  #     end
  #   end
  #   count
  # end

##############
### old unidirectional methods
  # def connect?(number = 4, letter = self.letter, count = 1)
  #   starting_node, node = self, self
  #   @compass.each do |direction|
  #     until node.direction.nil? || node.direction.letter != letter
  #       return true if (count += 1) == number
  #       node = node.direction
  #     count = 1
  #     node = starting_node
  #     connect = false
  #   end
  # end

  # def connect(letter = self.letter)
  #   starting_node, node = self, self
  #   @compass.map {  |direction|
  #     count = 1
  #     node = starting_node
  #     until node.direction.nil? || node.direction.letter != letter
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
  
  #   until node.nil? || node.letter != letter
  #     count += 1
  #     node = node.direction
  #   end
  
  #   count
  # end
  
  # def connect?(number = 4, letter = self.letter)
  #   @compass.any? { |direction| count_connections(letter, direction) >= number }
  # end
  
  # def connect(letter = self.letter)
  #   @compass.map { |direction| count_connections(letter, direction) }.max
  # end

  # ^ thanks, chatGPT. you have to ask it the right questions, 
  # and verify/modify as necessary, and it'll show you good stuff

  # after realizing we need to count two directions at once and 
  # making sure chatGPT understood this, found a good solution, replacing above
  
  
  
  
  
  