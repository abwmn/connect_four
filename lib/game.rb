require_relative 'board'
require_relative 'picker'
require_relative 'prompter'
class Game
  include Picker
  include Prompter
  attr_reader :board, 
              :grid, 
              :under, 
              :winner,
              # :lastwinner,
              # :foe_moves, 
              # :player_moves,
              :moves,
              :wins,
              :losses,
              :draws,
              :difficulty 

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @winner = false
    # @lastwinner = false
    @message = ''
    # @foe_moves = 0
    # @player_moves = 0
    @moves = 0
    @wins = 0
    @losses = 0
    @draws = 0
    @difficulty = ''
  end

  def start
    clear
    puts "Welcome to Connect 4!"
    playorquit
  end

  def play
    reset
    take_turns until !@under
  end

  def reset
    @under = true
    @board.clear
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

  def over(result)
    @under = false
    @winner = result
    case @winner
    when 'X'
      @message = "you WIN!! Good game!"
      @wins += 1
    when 'O'
      @message = "you LOSE. Better luck next time!"
      @losses += 1
    when 'none'
      @message = "TIE GAME!?! Wow!! Good game!"
      @draws += 1
    end
    @board.render("...oh SNAP! #{@message}")
    sleep(2)
    playorquit
  end
end