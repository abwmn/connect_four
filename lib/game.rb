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
      @player_moves += 1
      @board.render("\nThe foe plots a cunning move.")
      sleep(2)
      @board.place("O", pick)
      @foe_moves += 1
    end
  end

  def fresh_start
    @board.clear
    @under = true
    @foe_moves = 0
    @player_moves = 0
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
    movescores = {}
    return rand(0..6) if @foe_moves < 1
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      heading_scores = {}
      if        node && node.connect?(4, 'O')
        return col
      elsif     node && node.connect?(4, 'X')
        movescores[col] = 4
      elsif     node && node.connect?(3, 'O')
          if !node.n && node.count('s') == 2
            movescores[col] = 1
          else
            movescores[col] = 3
          end
      elsif    node
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

        # node.compass.each do |to, fro|
        #   if ((!node.send(to)  || node.send(to).letter  == 'X') &&
        #         node.count(fro,'O') == 2)
        #         heading_scores[to] = 0
        #   else
        #         heading_scores[to] = (node.count(to, 'O') + node.count(fro, 'O') + 1)
        #   end
        #   if ((!node.send(fro) || node.send(fro).letter == 'X') &&
        #         node.count(to, 'O') == 2)
        #         heading_scores[fro] = 0
        #   else
        #         heading_scores[fro] = (node.count(to, 'O') + node.count(fro, 'O') + 1)
        #   end
        # end
        # movescores[col] = heading_scores.values.max