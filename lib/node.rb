class Node
  attr_reader :letter, :empty, :ne, :e, :se, :s, :nw, :w, :sw
  def initialize
    @letter = '.'
    @empty = (@letter == '.')
    @ne = ne
    @e = e
    @se = se
    @s = s
    @nw = nw
    @w = w
    @sw = sw
  end
end