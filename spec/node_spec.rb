require './spec/spec_helper'

RSpec.describe do
  before(:each) do

  end

  it 'exists' do
    board = Board.new
    grid = board.grid
    node = grid[0][0]
    expect(node).to be_a(Node)
  end

  it 'has attributes' do
    board = Board.new
    grid = board.grid
    node = grid[0][0]
    expect(node).to be_a(Node)
    expect(node.letter).to eq('.')
    require 'pry'; binding.pry
    node.link_up
    expect(node.ne).to eq(grid[1][1])
    expect(node.e).to eq(grid[1][0])
    expect(node.se).to eq(nil)
    expect(node.s).to eq(nil)
    expect(node.sw).to eq(nil)
    expect(node.w).to eq(nil)
    expect(node.nw).to eq(nil)
    expect(node.empty?).to eq(true)
  end

  # it 'can count' do
  #   board = Board.new
  #   grid = board.grid
  #   board.place('X', 0)
  #   expect(grid[0][0].letter).to eq('X')
  #   expect(grid[0][0].connect).to eq(1)
  # end
end