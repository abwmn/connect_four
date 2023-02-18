require 'node'

class Column
  attr_reader :nodes, :name
  def initialize(name)
    @nodes = []
    @name = name
  end

  def add_node(node)
    @nodes << node
  end
end