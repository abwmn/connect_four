class Node
  attr_accessor :ne, :e, :se, :s, :sw, :w, :nw
  attr_reader :letter

  def initialize(col, row)
    @letter = '.'
    @ne = nil
    @e  = nil
    @se = nil
    @s  = nil
    @sw = nil
    @w  = nil
    @nw = nil
  end

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