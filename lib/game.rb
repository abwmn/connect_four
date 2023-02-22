require_relative 'board'
require_relative 'picker'
class Game
  include Picker
  attr_reader :board, 
              :grid, 
              :under, 
              :winner,
              :lastwinner,
              # :foe_moves, 
              # :player_moves,
              :moves,
              :player_wins,
              :foe_wins,
              :draws,
              :difficulty 

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @winner = false
    @lastwinner = false
    @message = ''
    # @foe_moves = 0
    # @player_moves = 0
    @moves = 0
    @player_wins = 0
    @foe_wins = 0
    @draws = 0
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
      case answer = gets.chr.downcase
      when 'p'
        selectdifficulty
      when 'q'
        puts "\e[H\e[2J" 
        abort("See you next time!")
      else
        if !@under
          puts "\e[H\e[2J"
          @board.render("\noh SNAP! #{@message}\n")
        else
          start
        end
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
    # @foe_moves = 0
    # @player_moves = 0
    @moves = 0
  end

  def take_turns
    @board.render
    @board.place("X", prompt)
    @moves += 1 #; @player_moves += 1
    @board.render("\nThe foe plots a cunning move.")
    sleep(1.5)
    @board.place("O", pick)
    @moves += 1 #; @foe_moves += 1
  end

  def prompt
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }.freeze
    loop do
      print "\nEnter A-G to place your X, or R for random!\n"
      # print "or \"check\" to test your move!\n"
      pick = gets.chomp.downcase
      if columns.key?(pick) && @grid[columns[pick]][5].empty?
        return columns[pick]
      elsif pick == 'r'
        col = nil
        loop do 
          col = rand(0..6)
          node = @grid[col].find{|node| node.empty?}
          break if node
        end
        return col
      else
        puts "\e[H\e[2J"
        @board.render
      end
    end
  end
  def over(winner)
    @under = false
    @winner = winner
    @message = case winner
    when 'X'
      "you WIN!! Good game!"
    when 'O'
      "you LOSE. Better luck next time!"
    when 'draw'
      "TIE GAME!?! Wow!! Good game!"
    end
    @board.render("\noh SNAP! #{@message}")
    sleep(2)
    playorquit
  end
end