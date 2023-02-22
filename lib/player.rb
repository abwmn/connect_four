class Player
  attr_reader :letter
  def initialize
    @letter = ''
  end
  
  def change_letter(new_letter)
    @letter = "#{new_letter}"
  end
end