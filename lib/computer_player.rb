require_relative 'picker'
require_relative 'player'
require_relative 'node'
require_relative 'board'
class Computer < Player
  include Picker
  attr_accessor :difficulty
  attr_reader  :letter, :turn
  def initialize
    @difficulty = ''
    @turn = 'c'
  end
  
  def change_letter(new_letter)
    super
  end
end