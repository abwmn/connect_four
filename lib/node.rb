class Node
  attr_accessor :letter, :n, :ne, :e, :se, :s, :sw, :w, :nw
  
  def initialize
    @letter = '.'
    @n = nil
    @ne = nil
    @e = nil
    @se = nil
    @s = nil
    @sw = nil
    @w = nil
    @nw = nil
  end

  def empty?
    @letter == '.'
  end

  def count(direction, letter = @letter, count = 0)
    node = self
    return count unless node&.send(direction)&.letter == letter
    node.send(direction).count(direction, letter, count + 1)
  end

  def connect(letter = @letter)
    compass = {'ne'=>'sw', 'se'=>'nw', 'e'=>'w', 's'=>'n'}
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