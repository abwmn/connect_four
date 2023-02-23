require_relative 'Picker'
require_relative 'player'
class Human < Player
  attr_reader :type, :letter
  include Picker
  def initialize
    @type = 'h'
  end
  
  def change_letter(new_letter)
    super
  end
end