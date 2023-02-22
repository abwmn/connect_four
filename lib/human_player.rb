require_relative 'Picker'
require_relative 'player'
class Human < Player
  attr_reader :turn
  include Picker
  def initialize
    @turn = 'h'
  end
  
  def change_letter(new_letter)
    super
  end
end