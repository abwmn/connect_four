class Game
  attr_reader :board, 
              :grid, 
              :under, 
              :result,
              :foe_moves, 
              :player_moves

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = false
    @result = ''
    @foe_moves = 0
    @player_moves = 0
  end

  def start
    puts "\e[H\e[2J"
    puts "Welcome to Connect 4!"
    sleep(2)
    select_difficulty
    playorquit
  end

  def select_difficulty
    puts "\e[H\e[2J"
    answer = gets.chr.downcase
    puts "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
    if answer = 'e'
      puts "\e[H\e[2J"
      puts "You chose Easy!!"
    elsif answer = 'm' 
      puts "\e[H\e[2J"
      puts "You chose Medium!"

    elsif answer = 'h'
      puts "\e[H\e[2J"
      puts "You chose...HARD?!"
    end
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

  def fresh_start
    @board.clear
    @under = true
    @foe_moves = 0
    @player_moves = 0
    @result = ''
  end

  def play
    fresh_start
    until !@under
      @board.render
      @board.place("X", prompt)
      @player_moves += 1
      @board.render("\nThe foe plots a cunning move.")
      sleep(2)
      @board.place("O", pick)
      @foe_moves += 1
    end
  end

  def prompt
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }
    loop do
      print "Place your X!\n"
      pick = gets.chomp.downcase
      if columns.key?(pick) && @grid[columns[pick]][5].empty?
        return columns[pick]
      else
        puts "\e[H\e[2J"
        @board.render("\nInvalid input. ")
      end
    end
  end

  def pick
    movescores = {}
    return rand(0..6) if @foe_moves < 2
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if       node && node.connect?(4, 'O')
        return col
      elsif    node && node.connect?(4, 'X')
        return col
      elsif    node && node.connect?(3, 'O')
        if   !node.n && node.count('s', 'O') == 2 ||
             !node.w && node.count('e', 'O') == 2 ||
             !node.e && node.count('w', 'O') == 2 ||
             !node.s && node.count('n', 'O') == 2
             movescores[col] = 1
        else
          movescores[col] = 3
        end
      elsif node 
        movescores[col] = node.connect('O')
      else
        movescores[col] = 0
      end
    end
    movescores.key(movescores.values.max) 
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
    sleep(6)
    playorquit
  end
end