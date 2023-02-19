require_relative 'node'
class Board
  attr_reader :grid

  def initialize
    @grid = {}
    (0..6).each do |col|
      @grid[col] = Array.new(6) { |row| Node.new(col, row, self) }
    end
  end

  def places(l, col = rand(0..6))
    placement = @grid[col].find {|node| node.empty?}
    placement.letter = l
    col
  end

  def place(letter, col)
    placement = @grid[col].find {|node| node.empty?}
    placement.letter = letter
  end

  def render
    puts 'A B C D E F G'
    holder = []
    (0..5).reverse_each do |row|
      (0..6).each do |col|
        holder << @grid[col][row].letter
     end
        puts holder.join(" ")
        holder.clear
    end
  end
end