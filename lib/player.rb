class Player
  attr_reader :letter
  def initialize(game)
    @letter = ''
    @game = game
    @human = false
    @computer = false
  end
  
  def change_letter(new_letter)
    @letter = "#{new_letter}"
  end
end