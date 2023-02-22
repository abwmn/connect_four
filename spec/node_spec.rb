require './spec/spec_helper'

RSpec.describe do
  before(:each) do
    @game = Game.new #initialize game bc board.render references game state
    @board = @game.board
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
    expect(@node.count('se')).to eq(3)
    expect(@node.count('se', 'x')).to eq(0)
    @node.se.letter='X'
    expect(@node.connect('X')).to eq(2)
    @node.letter = 'X'
    @node.nw.letter = 'X'
    @board.render
    expect(@node.count('se', 'X')).to eq(1)
    expect(@node.connect('.') > 4)
    expect(@node.connect('X')). to eq(3)
    expect(@node.connect?).to eq(false)
    expect(@node.connect?(4, '.')).to eq(true)
    expect(@node.connect?(4, 'O')).to eq(false)
  end

  it 'can render' do
    node = @node
    last_node = node
    compass = ['ne', 'sw', 'se', 'nw', 'e', 'w', 's', 'n']
    direction = compass[rand(0..7)]
    (0..99).each do |step|
      until node.send(direction)
        direction = compass[rand(0..7)]
      end
      last_node.letter = '.'
      node.letter = 'O'
      node.send(direction).letter = 'X'
      node.send(direction)&.send(direction)&.letter = direction
      last_node = node
      node = node.send(direction)
      @board.render
    end
  end

  it 'can check next empty across connections' do
    node = @node
    node.letter = 'X'
    node.e.letter = 'X'
    node.w.letter = 'X'
    node.w.w.letter = 'O'
    expect(node.next_empty?('w')).to eq(false)
    expect(node.next_empty?('e')).to eq(true)
    expect(node.next_empty?('n')).to eq(true)
  end
end