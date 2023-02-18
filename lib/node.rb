class Node 
  attr_accessor :letter
  attr_reader :ne, :e, :se, :s, :sw, :w, :nw

  def initialize(col, row, board)
    @letter = '.'
    @grid = board.grid
    @ne ||= @grid[col+1][row+1] if @grid[col+1]
    @e  ||= @grid[col+1][row] if @grid[col+1]
    @se ||= @grid[col+1][row-1] if @grid[col+1]
    @s  ||= @grid[col][row-1] if @grid[col]
    @sw ||= @grid[col-1][row-1] if @grid[col-1]
    @w  ||= @grid[col-1][row] if @grid[col-1]
    @nw ||= @grid[col-1][row+1] if @grid[col-1]
  end

  compass = {ne: sw, e: w, se: nw, s: nil}

  def empty?
    @letter == '.'
  end

  def count(direction, letter, count = 0)
    node = self
    return count unless node&.direction&.letter == letter
    node.direction.count(direction, letter, count + 1) 
  end

  def connect(letter = @letter)
    connex = 0
    compass.each do |forth, back|
      to = count(forth, letter)
      fro = count(back, letter)
      total = to + fro + 1
      connex = [total, connex].max
    end
    connex
  end

  def connect?(length = 4, letter = @letter)
    connect(letter) >= length
  end
end