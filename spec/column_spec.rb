require './lib/column'
require 'rspec'

RSpec.describe Column do
  before(:each) do
    @column = Column.new("A")
  end
  
  it 'exists' do
    expect(@column).to be_a(Column)
  end

  it 'has name' do
    expect(@column.name).to eq("A")
  end

  it 'holds nodes' do
    node1= Node.new
    node2= Node.new
    node3= Node.new
    node4= Node.new
    node5= Node.new
    node6= Node.new
    @column.add_node(node1)
    @column.add_node(node2)
    @column.add_node(node3)
    @column.add_node(node4)
    @column.add_node(node5)
    @column.add_node(node6)

    expect(@column.nodes).to eq([node1, node2, node3, node4, node5, node6])
    expect(@column.nodes[2]).to eq(node3)
  end

end