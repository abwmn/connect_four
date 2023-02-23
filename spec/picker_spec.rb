require './spec/spec_helper'
require './lib/requirements'

RSpec.describe Picker do
  before(:each) do
    @game = Game.new
    @board = @game.board
    @grid = @board.grid
  end

  it 'can pick random' do
    expect(@board.full?).to eq(false)
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(false)
    @board.place('X', @game.easy_pick)
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(true)
  end

  it 'can pick medium' do
    expect(@board.full?).to eq(false)
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(false)
    @board.place('X', @game.medium_pick('X', 'O'))
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(true)
  end

  it 'can pick hard' do
    expect(@board.full?).to eq(false)
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(false)
    @board.place('X', @game.hard_pick('X', 'O'))
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(true)
  end

  it 'can pick insane' do
    expect(@board.full?).to eq(false)
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(false)
    @board.place('X', @game.insane_pick('X', 'O'))
    expect(@grid.flatten.any?{|node|!node.empty?}).to eq(true)
  end
end