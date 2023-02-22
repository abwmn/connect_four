require_relative 'picker'
require_relative 'player'
class Computer < Player
  include Picker
  attr_accessor :difficulty
  attr_reader  :letter, :turn
  def initialize #maybe use initialize to set difficulty or turn or something, lol
    @difficulty = ''
    @turn = 'c'
  end

  def change_letter(new_letter)
    super
  end
end