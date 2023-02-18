class Board
  attr_reader :grid

  def initialize
    @grid = {}
    (0..6).each do |col|
      @grid[col] = Array.new(6) { |row| Node.new(col, row) }
    end
    link_nodes
  end

  def get_node(col, row)
    @grid[col][row] if @grid[col] && @grid[col][row]
  end
  
  def link_nodes
    (0..6).each do |col|
      (0..5).each do |row|
        node = get_node(col, row)
        node.ne = get_node(col+1, row+1)
        node.e  = get_node(col+1, row)
        node.se = get_node(col+1, row-1)
        node.s  = get_node(col, row-1)
        node.sw = get_node(col-1, row-1)
        node.w  = get_node(col-1, row)
        node.nw = get_node(col-1, row+1)
      end
    end
  end

  def place(col = rand(0..6), letter)
    placement = @grid.col.find {|node| node.letter == '.'}
    placement.letter == "#{letter}"
  end
end