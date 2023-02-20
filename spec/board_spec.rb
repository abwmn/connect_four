require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @game = Game.new
    @board = @game.board
    @grid = @board.grid
  end

  it 'exists' do
    expect(@board).to be_a(Board)
  end

  it 'is a grid array' do  
    expect(@grid).to be_an(Array)
  end

  it 'is full of nodes' do
    expect(@grid[0][0]).to be_a(Node)
  end

  it 'places' do
    @board.place("X", 2)

    expect(@grid[2][0].letter).to eq("X")
  end

  it 'places random' do
    expect(@grid[@board.place("X")].find {|node|!node.empty?}.letter).to eq("X")
  end

  it 'knows when full' do
    (0..6).each do |col|
      (0..5).each do |row|
        @grid[col][row].letter = '.'
      end
    end
    expect(@board.full?).to eq(true)
  end
end