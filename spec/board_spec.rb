require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @game = Game.new
    @board = @game.board
  end

  it 'exists' do
    expect(@board).to be_a(Board)
  end

  it 'has a grid hash' do  
    expect(@board.grid).to be_an(Array)
  end

  it 'is full of nodes' do
    expect(@board.grid[0][0]).to be_a(Node)
  end

  it 'places' do
    @board.places("X", 2)

    expect(@board.grid[2][0].letter).to eq("X")
  end

  it 'places random' do
    expect(@board.grid[@board.places("X")].find {|node|!node.empty?}.letter).to eq("X")
    @game.start
  end

end