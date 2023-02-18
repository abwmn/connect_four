require './lib/game'
require 'rspec'

RSpec.describe do
  before(:each) do
    @game = Game.new
  end
  it 'exists' do
    expect(@game).to be_a(Game)
  end
end