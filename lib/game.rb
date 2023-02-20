class Game
  attr_reader :board, :grid, :under, :result, :player_turn, :foe_turn

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
    fresh_start
    until !@under
      @board.render
      @board.place("X", prompt)
      @player_turn += 1
      @board.render("\nThe foe plots a cunning move.")
      sleep(2)
      @board.place("O", pick)
      @foe_turn += 1
    end
  end

  def fresh_start
    @board.clear
    @under = true
    @foe_turn = 0
    @player_turn = 0
    @result = ''
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
    results = {}
    return rand(0..6) if @foe_turn < 2
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, 'O')
        return col
      elsif node && node.connect?(4, 'X')
        return col
      elsif node && node.connect?(3, 'O')
        if (!node.n && (node.s.s.letter == node.s.letter)) || 
          (!node.w && (node.e.e.letter == node.e.letter)) || 
          (!node.e && (node.w.w.letter == node.w.letter))
          results[col] = 1
        else
          results[col] = 3
        end
      elsif node 
        results[col] = node.connect('O')
      else
        results[col] = 0
      end
    end
    results.key(results.values.max) 
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