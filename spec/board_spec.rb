require 'rspec'
require './lib/board'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @column0 = Column.new("A")
    @column1 = Column.new("B")
    @column2 = Column.new("C")
    @column3 = Column.new("D")
    @column4 = Column.new("E")
    @column5 = Column.new("F")
    @column6 = Column.new("G")
  end

  it 'exists' do
    expect(@board).to be_a(Board)
  end

  it 'adds columns' do
    @board.add_column(@column0)
    @board.add_column(@column1)
    @board.add_column(@column2)
    @board.add_column(@column3)
    @board.add_column(@column4)
    @board.add_column(@column5)
    @board.add_column(@column6)

    expect(@board.columns).to eq({"A"=>[], "B"=>[], "C"=>[], "D"=>[], "E"=>[], "F"=>[], "G"=>[]})
  end

end

