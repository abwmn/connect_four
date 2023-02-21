require_relative 'node'
class Board
  attr_reader :grid
  
  def initialize(game=nil)
    @game = game
    @grid = Array.new(7) { Array.new(6) }
    (0..6).each do |col|
      (0..5).each do |row|
        @grid[col][row] = Node.new
      end
    end
    link_up
  end

  def link_up
    (0..6).each do |col|
      (0..5).each do |row|
        node = @grid[col][row]
        if col < 6
          node.e  = @grid[col+1][row]   
          node.se = @grid[col+1][row-1] unless row < 1
          node.ne = @grid[col+1][row+1] unless row > 4
        end
        if row > 0
          node.s  = @grid[col][row-1]
        end
        if row < 4
          node.n = @grid[col][row+1]
        end
        if col > 0
          node.w  = @grid[col-1][row]
          node.sw = @grid[col-1][row-1] unless row < 1
          node.nw = @grid[col-1][row+1] unless row > 4
        end
      end
    end
  end

  def render(message='')
    puts "\e[H\e[2J"
    puts 'A B C D E F G'
    next_row = []
    (0..5).reverse_each do |row|
      (0..6).each do |col|
        next_row << @grid[col][row].letter
     end
        puts next_row.join(" ")
        next_row.clear
    end
    puts "\nMoves: #{@game.player_moves + @game.foe_moves}"
    puts message
  end

  def place(letter, col)
    node = @grid[col].find {|node| node.empty?}
    node.letter = letter
    if node.connect?(4) 
      @game.over(letter)
    elsif full?
      @game.over('draw')
    end
    col
  end

  def full?
    !@grid.flatten.any?{ |node| node.letter == '.' }
  end

  def clear
    @grid.flatten.each { |node| node.letter =  '.' }
  end
end

# def place(letter, col)
#   node = @grid[col].find {|node| node.empty?}
#   node.letter = letter
#   if node.connect?(4) || full?
#     @game.over
#   end
# end
