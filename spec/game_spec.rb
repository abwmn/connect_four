require './spec/spec_helper.rb'

RSpec.describe do
  before(:each) do
    @game = Game.new
  end
  it 'exists' do
    expect(@game).to be_a(Game)
  end

  it 'has attributes' do
    expect(@game.board).to be_a(Board)
    # expect(@game.grid).to eq(@board.grid)
    expect(@game.under).to eq(true)
    expect(@game.winner).to eq(false)
    expect(@game.lastwinner).to eq(false)
    # expect(@game.message).to eq('')
    expect(@game.moves).to eq(0)
    expect(@game.player_wins).to eq(0)
    expect(@game.foe_wins).to eq(0)
    expect(@game.draws).to eq(0)
    expect(@game.player1).to eq(false)
    expect(@game.player2).to eq(false)
  end
end