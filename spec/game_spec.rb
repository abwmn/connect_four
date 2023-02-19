require './spec/spec_helper.rb'

RSpec.describe do
  before(:each) do
    @game = Game.new
  end
  it 'exists' do
    expect(@game).to be_a(Game)
  end
end

@game = Game.new
@game.start