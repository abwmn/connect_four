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

  def count(heading, letter = @letter, count = 0)
    return count unless self&.send(heading)&.letter == letter
    self.send(heading).count(heading, letter, count + 1)
  end

  def connect(letter = @letter, connex = 0)
    compass = {'ne'=>'sw', 'se'=>'nw', 'e'=>'w', 's'=>'n'}
    compass.each do |fore, aft|
      to = count(fore, letter)
      fro = count(aft, letter)
      total = to + fro + 1
      connex = [total, connex].max
    end
    connex
  end

  def connect?(length = 4, letter = @letter)
    connect(letter) >= length
  end
end