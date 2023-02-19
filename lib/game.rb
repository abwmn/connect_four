require './spec/spec_helper'

class Game
  attr_reader :board, :game, :grid
  attr_accessor :under

  def initialize
    @game = self
    @under = true
    @board = Board.new(self)
    @grid = @board.grid
    @result = ''
    @p_or_q = 'q'
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
    @under = true
    until @under == false
      @board.render
      @game.prompt #@board.places(player)
      @board.render("\nThe computer will now play a most cunning move.")
      sleep(2)
      @board.places("O")
    end
  end

  def prompt
    puts "Place your X!"
    col = gets.chomp
    if col.downcase    == 'a' && @grid[0][5].empty?
      col = 0
    elsif col.downcase == 'b' && @grid[1][5].empty?
      col = 1
    elsif col.downcase == 'c' && @grid[2][5].empty?
      col = 2
    elsif col.downcase == 'd' && @grid[3][5].empty?
      col = 3
    elsif col.downcase == 'e' && @grid[4][5].empty?
      col = 4
    elsif col.downcase == 'f' && @grid[5][5].empty?
      col = 5
    elsif col.downcase == 'g' && @grid[6][5].empty?
      col = 6
    else 
      puts "\e[H\e[2J"
      puts "Invalid input, try again."
      @board.render
      prompt
    end
    @board.places('X', col)
  end

  def over
    @under = false
    @board.render("\nOh snap! Good game!")
    sleep(3)
    @board.clear
    playorquit
  end
    # if result == 'X'
    #   puts "You Win!"
    # elsif result == 'O'
    #   puts "You lose!"
    # elsif result == 'draw' 
    #   puts "Tie game!"
    # else
    #  puts "error: invalid end of game"
    # end
end