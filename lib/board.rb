require_relative 'node'
class Board
  attr_reader :grid
  
  def initialize
    @grid = Array.new(7) { Array.new(6) }
    (0..6).each do |col|
      (0..5).each do |row|
        @grid[col][row] = Node.new
      end
    end
    
    (0..6).each do |col|
      (0..5).each do |row|
        if col > 0
          @grid[col][row].w = @grid[col-1][row]
          if row > 0
            @grid[col][row].nw = @grid[col-1][row-1]
          end
          if row < 5
            @grid[col][row].sw = @grid[col-1][row+1]
          end
        end
        if col < 6
          @grid[col][row].e = @grid[col+1][row]
          if row > 0
            @grid[col][row].ne = @grid[col+1][row-1]
          end
          if row < 5
            @grid[col][row].se = @grid[col+1][row+1]
          end
        end
        if row > 0
          @grid[col][row].n = @grid[col][row-1]
        end
        if row < 5
          @grid[col][row].s = @grid[col][row+1]
        end
      end
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
