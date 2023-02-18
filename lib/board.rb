require 'column'

class Board
  attr_reader :columns
  def initialize
    @columns = {}
  end

  def add_column(col)
    @columns["#{col.name}"] = col.nodes
  end
end