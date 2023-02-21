require_relative 'board'
class Game
  attr_reader :board, 
              :grid, 
              :under, 
              :winner,
              :lastwinner,
              :foe_moves, 
              :player_moves,
              :difficulty

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @winner = false
    @lastwinner = false
    @message = ''
    @foe_moves = 0
    @player_moves = 0
    @difficulty = ''
  end

  def start
    puts "\e[H\e[2J"
    puts "Welcome to Connect 4!"
    playorquit
  end

  def playorquit
    loop do
      puts "\nEnter p to play, or q to quit!\n"
      answer = gets.chr.downcase
      if answer.downcase == 'p'
        selectdifficulty
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

  def selectdifficulty
    puts "\e[H\e[2J"
    puts "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
    case answer = gets.chr.downcase
    when 'e'
      puts "\e[H\e[2J"
      puts "You chose Easy!"
    when 'm' 
      puts "\e[H\e[2J"
      puts "You chose Medium!"
    when 'h'
      puts "\e[H\e[2J"
      puts "You chose HARD!!"
    when 'i'
      puts "\e[H\e[2J"
      puts "Who told you about the Insane difficulty?!"
    else
      selectdifficulty
    end
    @difficulty = answer
    sleep(1.5)
    puts "\nGood luck, have fun! Let the games begin!"
    sleep(1.5)
    play
  end

  def play
    reset
    until !@under
      take_turns
    end
  end

  def reset
    @under = true
    @lastwinner = @winner
    @winner = false
    @board.clear
    @foe_moves = 0
    @player_moves = 0
  end

  def take_turns
    @board.render
    @board.place("X", prompt)
    @player_moves += 1
    @board.render("\nThe foe plots a cunning move.")
    sleep(1.5)
    @board.place("O", pick)
    @foe_moves += 1
  end

  def prompt
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }.freeze
    loop do
      print "\nPlace your X from A to G!\n"
      pick = gets.chomp.downcase
      if columns.key?(pick) && @grid[columns[pick]][5].empty?
        return columns[pick]
      else
        puts "\e[H\e[2J"
        @board.render
      end
    end
  end

  def pick
    case @difficulty
    when 'e'
      easy_pick
    when 'm'
      medium_pick
    when 'h'
      hard_pick
    when 'i'
      insane_pick
    end
  end

  def easy_pick
    col = nil
    loop do
      col = rand(0..6)
      node = @grid[col].find {|node| node.empty? }
      break if node
    end
    col
  end

  def medium_pick
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, 'O')
        return col
      elsif node && node.connect?(4, 'X')
        movescores[col] = 2
      elsif node
        movescores[col] = 1
      else
        movescores[col] = 0
      end
    end
    movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
  end

  def hard_pick
    movescores = {}
    return rand(0..6) if @foe_moves < 2
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if       node && node.connect?(4, 'O')
        return col
      elsif    node && node.connect?(4, 'X')
        movescores[col] = 4
      elsif    node && node.connect?(3, 'O')
        if   !node.n && node.count('s', 'O') == 2
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
     movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
    end

  def over(winner)
    @under = false
    @winner = winner
    @message = if winner == 'X'
      "You win!"
    elsif winner == 'O'
      "You lose."
    elsif winner == 'draw'
      "Tie game!"
    end
    @board.render("\nOh snap! #{@message} Good game!")
    sleep(2)
    playorquit
  end
end