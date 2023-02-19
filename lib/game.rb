require './spec/spec_helper'

class Game
  attr_reader :board, :game, :grid
  attr_accessor :over

  def initialize
    @game = self
    @board = Board.new(self)
    @grid = @board.grid
    @result = ''
  end

  def start
    puts "Welcome to Connect 4!"
    playorquit
  end

  def playorquit
    puts "Enter p to play, or q to quit!"
    p_or_q = gets.chomp
    if p_or_q.downcase == 'p'
      puts "Let the games begin!"
      play
    elsif p_or_q.downcase == 'q'
      puts "See you next time!"
    else
      playorquit
    end
  end

  def prompt
    puts "Place your X!"
    col = gets.chomp
    if col.downcase == 'a' && @grid[0][5].empty?
      @board.places("X", 0)
    elsif col.downcase == 'b'&& @grid[1][5].empty?
      @board.places("X", 1)
    elsif col.downcase == 'c' && @grid[2][5].empty?
      @board.places("X", 2)
    elsif col.downcase == 'd' && @grid[3][5].empty?
      @board.places("X", 3)
    elsif col.downcase == 'e' && @grid[4][5].empty?
      @board.places("X", 4)
    elsif col.downcase == 'f' && @grid[5][5].empty?
      @board.places("X", 5) 
    elsif col.downcase == 'g' && @grid[6][5].empty?
      @board.places("X", 6)
    else 
      puts "Invalid input"
      self.prompt
    end
  end

  # def over?
  #   false
  # end

  def over
    @board.render("Oh snap! Good game!")
    self.playorquit
  end
  
  def play
    @board.clear
    (0..40).each do
      @board.render
      @game.prompt
      @board.render
      puts "The computer will now play a most cunning move."
      sleep(1)
      @board.places("O")
    end
    if result == 'X'
      puts "You Win!"
    elsif result == 'O'
      puts "You lose!"
    elsif result == 'draw' 
      puts "Tie game!"
    else
     puts "error: invalid end of game"
    end
  end
end