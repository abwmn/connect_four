require 'rspec'
require './lib/node'

RSpec.describe Node do
  before (:each) do
    @node = Node.new
  end
  
  it 'exists' do
    expect(@node).to be_a(Node)
  end
end