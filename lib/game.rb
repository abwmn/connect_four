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
              :current_player
  attr_accessor :player1,
                :player2

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @under = true
    @winner = false
    @message = ''
    @moves = 0
    @wins = 0
    @losses = 0
    @draws = 0
    @difficulty = ''
    @player1 = Player.new
    @player2 = Player.new
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
    if @player1.type == 'h'
      @board.place(@player1.letter, prompt)
    elsif @player1.type == 'c'
       @board.place(@player1.letter, pick(@player1))
       sleep(1.2)
    end
    @moves += 1
    @board.render("Player 2's turn...")
    if @player2.type == 'h'
      @board.place(@player2.letter, prompt)
    elsif @player2.type == 'c'
      @board.place(@player2.letter, pick(@player2))
      sleep(1.2)
    end
    @moves += 1
  end

  def over(result)
    @under = false
    @winner = result
    case @winner
    when 'X'
      @message = "Player1 WINS!!"
      @wins += 1
    when 'O'
      @message = "Player2 WINS!!"
      @losses += 1
    when 'none'
      @message = "TIE GAME!?! Wow!!"
      @draws += 1
    end
    @board.render("...oh SNAP! #{@message} Good game!")
    sleep(2)
    playorquit
  end
end