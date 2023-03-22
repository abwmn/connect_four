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
              :player2,
              :count

  def initialize
    @board = Board.new(self)
    @grid = @board.grid
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @under = true
    @winner = false
    @message = ''
    @moves = 0
    @wins = 0
    @losses = 0
    @draws = 0
    @count = 0
    @start = 0
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
    @board.render("X's turn...")
    take_turn(@player1)
    @board.render("O's turn...")
    take_turn(@player2)
  end

  def take_turn(player)
    if player.type == 'h'
      @board.place(player.letter, prompt(player.letter))
    elsif player.type == 'c'
      @board.place(player.letter, pick(player))
      # normal only:
      sleep(0.1)
    end
    @moves +=1
  end

  def over(result)
    @under = false
    @winner = result
    case @winner
    when 'X'
      @message = "X WINS!!"
      @wins += 1
    when 'O'
      @message = "O WINS!!"
      @losses += 1
    when 'none'
      @message = "TIE GAME!?! Wow!!"
      @draws += 1
    end
    @board.render("...oh SNAP! #{@message} Good game!")
    # normal:
    sleep(1)
    playorquit
    # autoplay 1000 games:
    # if @count < 999
    #   @count += 1
    #   play
    # else
    #   puts "Runtime: #{(Process.clock_gettime(Process::CLOCK_MONOTONIC) - @start).round(2)} sec"
    #   playorquit
    # end
  end
end