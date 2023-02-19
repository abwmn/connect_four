class Game
  attr_reader :board, :grid, :under, :result

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = false
    @result = ''
  end

  def start
    puts "\e[H\e[2J"
    puts "Welcome to Connect 4!"
    sleep(2)
    playorquit
  end

  def playorquit
    puts "\e[H\e[2J"
    puts "Enter p to play, or q to quit!"
    answer = gets.chomp
    if answer.downcase == 'p'
      puts "\e[H\e[2J"
      puts "Let the games begin!"
      play
    elsif answer.downcase == 'q'
      puts "\e[H\e[2J"
      abort("See you next time!")
    else
      playorquit
    end
  end

  def play
    @board.clear
    @under = true
    until !@under
      @board.render
      @board.place("X", prompt)
      @board.render("\nThe computer will now play a most cunning move.")
      sleep(2)
      @board.place("O")
    end
  end

  def prompt
    puts "Place your X!"
    letter = gets.chomp

    if letter.downcase    == 'a' && @grid[0][5].empty?
       return 0
    elsif letter.downcase == 'b' && @grid[1][5].empty?
       return 1
    elsif letter.downcase == 'c' && @grid[2][5].empty?
       return 2
    elsif letter.downcase == 'd' && @grid[3][5].empty?
       return 3
    elsif letter.downcase == 'e' && @grid[4][5].empty?
       return 4
    elsif letter.downcase == 'f' && @grid[5][5].empty?
       return 5
    elsif letter.downcase == 'g' && @grid[6][5].empty?
       return 6
    else
      puts "\e[H\e[2J"
      @board.render("\nInvalid input, try again.")
      prompt
    end
  end

  def over(winner)
    @under = false
    @result = winner
    @board.render("\nOh snap! Good game!")
    sleep(3)
    playorquit
  end
end

# if result == 'X'
#   puts "You Win!"
# elsif result == 'O'
#   puts "You lose!"
# elsif result == 'draw' 
#   puts "Tie game!"
# else
#  puts "error: invalid end of game"
# end