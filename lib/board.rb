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
end