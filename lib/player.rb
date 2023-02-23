class Player
  attr_reader :letter, :turn
  def initialize
    @letter = ''
    @turn = ''
  end
  
  def change_letter(new_letter)
    @letter = "#{new_letter}"
  end
end