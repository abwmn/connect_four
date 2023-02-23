require 'rspec'
require './lib/player'

RSpec.describe Player do
  before(:each) do
    @player = Player.new
  end
  it 'exists' do
    expect(@player).to be_a(Player)
  end

  it 'has letter' do
    expect(@player.letter).to eq('X')
  end

  it 'changes letter' do
    @player.change_letter('O')
    expect(@player.letter).to eq('O')
  end
end