class Player
  attr_accessor :letter, :type, :difficulty
  def initialize
    @letter = ''
    @type = ''
    @difficulty = ''
  end

  def set(type)
    @type = turn
  end
  
  def change_letter(new_letter)
    @letter = "#{new_letter}"
  end
end