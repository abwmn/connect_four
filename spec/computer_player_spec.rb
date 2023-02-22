require 'rspec'
require './lib/computer_player'

RSpec.describe Computer do
  before(:each) do
    @Computer = Computer.new
  end
  it 'exists' do
    expect(@Computer).to be_a(Computer)
  end

  it 'has turn' do
    expect(@Computer.turn).to eq('c')
  end

  it 'changes letter' do
    @Computer.change_letter('O')
    expect(@Computer.letter).to eq('O')
  end
end