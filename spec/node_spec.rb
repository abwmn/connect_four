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
    expect(@node.ne).to eq(@grid[4][2])
    expect(@node.e).to eq(@grid[4][3])
    expect(@node.se).to eq(@grid[4][4])
    expect(@node.s).to eq(@grid[3][4])
    expect(@node.sw).to eq(@grid[2][4])
    expect(@node.w).to eq(@grid[2][3])
    expect(@node.nw).to eq(@grid[2][2])
  end

  it 'can count' do
    # require 'pry'; binding.pry
    expect(@node.count("se")).to eq(2)
    expect(@node.count("se", 'x')).to eq(0)
    expect(@node.connect('x')).to eq(1)
    expect(@node.connect('.') > 4)
    expect(@node.connect?).to eq(true)
  end
end