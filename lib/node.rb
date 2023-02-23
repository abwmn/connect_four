class Node
  attr_accessor :letter, :n, :ne, :e, :se, :s, :sw, :w, :nw, :compass
  
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
    @compass = {'ne'=>'sw', 'se'=>'nw', 'e'=>'w', 's'=>'n'}
  end

  def empty?
    @letter == '.'
  end

  def count(heading, letter = @letter, count = 0)
    return count unless self&.send(heading)&.letter == letter
    self.send(heading).count(heading, letter, count + 1)
  end

  def connect(letter = @letter, connex = 0)
    @compass.each do |fore, aft|
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

  def next_empty?(heading, letter = @letter)
    node = self
    until node&.send(heading)&.letter != letter
      node = node&.send(heading)
    end
    node&.send(heading)&.empty?
  end

  def any_traps?(letter)
    @compass.each do |fore, aft|
      if self.next_empty?(fore, letter) && 
         self.next_empty?(aft, letter)  &&
         self.count(fore) + self.count(aft) + 1 == 3
       return true
      end
    end
    false
  end
end