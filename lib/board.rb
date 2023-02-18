class Board
  attr_reader :board

  def initialize
    @board = {}
    (0..6).each do |col|
      @board[col] = Array.new(6) { |row| Node.new(col, row, self) }
    end
  end
end