require_relative 'requirements'
class Game
  include Picker
  include Prompter
  attr_reader :board, 
              :grid, 
              :under, 
              :winner,
              :moves,
              :wins,
              :losses,
              :draws, 
              :player1,
              :player2

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @player1 = Player.new
    @player2 = Player.new
    @under = true
    @winner = false
    @message = ''
    @moves = 0
    @wins = 0
    @losses = 0
    @draws = 0
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
    take_turn(@player1)
    @board.render("Player 2's turn...")
    take_turn(@player2)
  end

  def take_turn(player)
    if player.type == 'h'
      @board.place(player.letter, prompt)
    elsif player.type == 'c'
      @board.place(player.letter, pick(player))
      sleep(1.2)
    end
    @moves +=1
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