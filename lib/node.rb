class Node
  attr_reader   :ne, :e, :se, :s, :sw, :w, :nw
  attr_accessor :letter

  def initialize(col, row, board)
    @letter = '.'
    @col = col
    @row = row
    @grid = board.grid
    @ne = @grid[@col+1] ? @grid[@col+1][@row+1] : nil
    # @e  = @grid[@col+1] ? @grid[@col+1][@row] : nil
    # @se = @grid[@col+1] ? @grid[@col+1][@row-1] : nil
    # @s  = @grid[@col] ?   @grid[@col][@row-1] : nil
    # @sw = @grid[@col-1] ? @grid[@col-1][@row-1] : nil
    # @w  = @grid[@col-1] ? @grid[@col-1][@row] : nil
    # @nw = @grid[@col-1] ? @grid[@col-1][@row+1] : nil
  end

  def link_up
    @ne = @grid[@col+1] ? @grid[@col+1][@row+1] : nil
    # @e  = @grid[@col+1] ? @grid[@col+1][@row] : nil
    # @se = @grid[@col+1] ? @grid[@col+1][@row-1] : nil
    # @s  = @grid[@col] ?   @grid[@col][@row-1] : nil
    # @sw = @grid[@col-1] ? @grid[@col-1][@row-1] : nil
    # @w  = @grid[@col-1] ? @grid[@col-1][@row] : nil
    # @nw = @grid[@col-1] ? @grid[@col-1][@row+1] : nil
  end

  def empty?
    @letter == '.'
  end

  def count(direction, letter, count = 0)
    link_up
    node = self
    return count unless node&.direction&.letter == letter
    node.direction.count(direction, letter, count + 1) 
  end

  def connect(letter = @letter)
    link_up
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
    connect(letter) >= length
  end
end