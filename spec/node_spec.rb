require 'rspec'
require './lib/node'

RSpec.describe do
  before(:each) do
    @node = Node.new(0,0)
  end

  it 'exists' do
    expect(@node).to be_a(Node)
  end

  it 'has attributes' do
    expect(@node.letter).to eq('.')
    expect(@node.ne).to eq(nil)
    expect(@node.e).to eq(nil)
    expect(@node.se).to eq(nil)
    expect(@node.s).to eq(nil)
    expect(@node.sw).to eq(nil)
    expect(@node.w).to eq(nil)
    expect(@node.nw).to eq(nil)
    expect(@node.empty?).to eq(true)
  end
end