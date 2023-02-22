require 'rspec'
require './lib/human_player'

RSpec.describe Human do
  before(:each) do
    @human = Human.new
  end
  it 'exists' do
    expect(@human).to be_a(Human)
  end

  it 'has turn' do
    expect(@human.turn).to eq('h')
  end

  it 'changes letter' do
    @human.change_letter('O')
    expect(@human.letter).to eq('O')
  end
end