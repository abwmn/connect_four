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
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }
    loop do
      print "Place your X!\n"
      letter = gets.chomp.downcase
      if columns.key?(letter) && @grid[columns[letter]][5].empty?
        return columns[letter]
      else
        puts "\e[H\e[2J"
        @board.render("\nInvalid input. ")
      end
    end
  end

  def over(winner)
    @under = false
    @result = winner
    message = if winner == 'X'
      "You win!"
    elsif winner == 'O'
      "You lose!"
    elsif @result == 'draw'
      "Tie game!"
    end
    @board.render("\nOh snap! #{message}\n\nGood game!")
    sleep(3)
    playorquit
  end
end