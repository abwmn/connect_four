require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require_relative 'player'
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
              :player_wins,
              :foe_wins,
              :draws,
              :player1,
              :player2, 
              :current_player

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @winner = false
    @lastwinner = false
    @message = ''
    @moves = 0
    @player_wins = 0
    @foe_wins = 0
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
    until !@under
      take_turns
    end
  end

  def reset
    @under = true
    @lastwinner = @winner
    @winner = false
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