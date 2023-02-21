class Game
  attr_reader :board, 
              :grid, 
              :under, 
              :result,
              :foe_moves, 
              :player_moves
              :difficulty
              :last_winner

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @result = ''
    @message = ''
    @lastwinner = ''
    @foe_moves = 0
    @player_moves = 0
    @difficulty = 'hard'
  end

  def start
    puts "\e[H\e[2J"
    puts "Welcome to Connect 4!"
    playorquit
  end

  def play
    reset
    until !@under
      take_turns
    end
  end

  def reset
    @under = true
    @board.clear
    @lastwinner = @result
    @result = ''
    @foe_moves = 0
    @player_moves = 0
  end

  def take_turns
    @board.render
    @board.place("X", prompt)
    @player_moves += 1
    @board.render("\nThe foe plots a cunning move.")
    sleep(2)
    @board.place("O", pick)
    @foe_moves += 1
  end

  def prompt
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }.freeze
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
    if @difficulty == 'easy'
      col = nil
      loop do
        col = rand(0..6)
        node = @grid[col].find {|node| node.empty? }
        break if node
      end
      col
    elsif @difficulty == 'hard'
      movescores = {}
      return rand(0..6) if @foe_moves < 1
      (0..6).each do |col|
        node = @grid[col].find { |node| node.empty?}
        if node && node.connect?(4, 'O')
          return col
        elsif node && node.connect?(4, 'X')
          movescores[col] = 4
        elsif node && node.connect?(3, 'O')
          if !node.n && node.count('s') == 2
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
  end

  def over(winner)
    @under = false
    @result = winner
    @message = if winner == 'X'
      "You win!"
    elsif winner == 'O'
      "You lose."
    elsif @result == 'draw'
      "Tie game!"
    end
    @board.render("\nOh snap! #{@message} Good game!")
    sleep(3)
    playorquit
  end

  def playorquit
    loop do
      puts "\nEnter p to play, or q to quit!\n"
      answer = gets.chomp.downcase
      if answer.downcase == 'p'
        puts "\e[H\e[2J" 
        puts "\nLet the games begin!"
        play
      elsif answer.downcase == 'q'
        puts "\e[H\e[2J" 
        abort("See you next time!")
      elsif !@under
        puts "\e[H\e[2J"
        @board.render("\nOh snap! #{@message} Good game!\n")
      else
        start
      end
    end
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