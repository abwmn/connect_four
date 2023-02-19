require './spec/spec_helper.rb'

RSpec.describe do
  before(:each) do
    @board = Board.new
    @grid = @board.grid
    @node = @grid[3][3]
  end

  it 'exists' do
    expect(@node).to be_a(Node)
  end

  it 'has attributes' do
    expect(@node).to be_a(Node)
    expect(@node.letter).to eq('.')
    @node.letter = 'X'
    expect(@node.ne).to eq(@grid[4][4])
    @node.ne.letter = 'O'
    @board.render
    expect(@node.e).to eq(@grid[4][3])
    expect(@node.se).to eq(@grid[4][2])
    expect(@node.s).to eq(@grid[3][2])
    expect(@node.sw).to eq(@grid[2][2])
    expect(@node.w).to eq(@grid[2][3])
    expect(@node.nw).to eq(@grid[2][4])
  end

  it 'can count' do
    # require 'pry'; binding.pry
    expect(@node.count("se")).to eq(3)
    expect(@node.count("se", 'x')).to eq(0)
    @node.se.letter='X'
    @board.render
    expect(@node.count('se', 'X')).to eq(1)
    expect(@node.connect('X')).to eq(2)
    expect(@node.connect('.') > 4)
    expect(@node.connect?).to eq(true)
    expect(@node.connect?(4, 'O')).to eq(false)
  end
end