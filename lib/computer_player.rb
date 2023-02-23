require_relative 'Picker'
require_relative 'Player'
class Computer < Player
  include Picker
  attr_accessor :difficulty
  attr_reader  :letter, :type
  def initialize
    @difficulty = ''
    @type = 'c'
  end
  
  def change_letter(new_letter)
    super
  end
end