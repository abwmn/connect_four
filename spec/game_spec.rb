require './spec/spec_helper.rb'

RSpec.describe do
  before(:each) do
    @game = Game.new
  end
  it 'exists' do
    expect(@game).to be_a(Game)
  end

  it 'initializes players' do
    expect(@game.player1.letter).to eq('X')
    expect(@game.player2.letter).to eq('O')
  end

  it 'initializes board' do
    @game.board.render
  end
end
