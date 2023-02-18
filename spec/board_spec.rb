require 'spec_helper'

RSpec.describe Board do
  before(:each) do 
    @board = Board.new
  end

  it 'exists' do
    expect(@board).to be_a(Board)
  end

  it 'has a grid hash' do  
    expect(@board.grid).to be_a(Hash)
  end

  it 'is full of nodes' do
    expect(@board.grid[0][0]).to be_a(Node)
  end

  it 'links nodes' do
    expect(@board.grid[0][0].ne).to eq(@board.grid[1][1])
    expect(@board.grid[3][5].sw).to eq(@board.grid[2][4])
  end
end