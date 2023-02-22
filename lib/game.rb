require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'player'
require_relative 'prompter'
require_relative 'picker'
require_relative 'prompter'
class Game
  include Picker
  include Prompter
  attr_reader :board, 
              :grid, 
              :under, 
              :winner,
              :lastwinner,
              :moves,
              :wins,
              :losses,
              :draws,
              :player1,
              :player2, 
              :current_player

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @winner = false
    # @lastwinner = false
    @message = ''
    @moves = 0
    @wins = 0
    @losses = 0
    @draws = 0
    @difficulty = ''
    @player1 = player1
    @player2 = player2
    @current_player = player1
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
      if @player1.turn == 'h'
        @board.place(@player1.letter, prompt)
      elsif @player1.turn == 'c'
       @board.place(@player1.letter, pick(@player1))
      else
        false
      end
    @moves += 1
    @board.render("\nYour move player two!")
    if @player2.turn == 'h'
      @board.place(@player2.letter, prompt)
    elsif @player2.turn == 'c'
      sleep(1.5)
     @board.place(@player2.letter, pick(@player2))
    else
      false
    end
  end

  def over(winner)
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