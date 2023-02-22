require 'rspec'
require './lib/player'

RSpec.describe Player do
  
  it 'exists' do
    player = Player.new

    expect(player).to be_a(Player)
  end
end