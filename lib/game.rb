require './spec/spec_helper'

class Game
  attr_reader :board, :game, :grid, :pick
  attr_accessor :under

  def initialize
    @game = self
    @under = true
    @board = Board.new(self)
    @grid = @board.grid
    @result = ''
    @pick = -1
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
      answer = ''
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
      prompt 
      @board.places('X', @pick)
      @board.render("\nThe computer will now play a most cunning move.")
      sleep(2)
      @board.places("O")
    end
  end

  def prompt
    puts "Place your X!"
    letter = gets.chomp
    @pick = -1
    until @pick.between?(0,6)
      if letter.downcase    == 'a' && @grid[0][5].empty?
        @pick = 0
      elsif letter.downcase == 'b' && @grid[1][5].empty?
        @pick = 1
      elsif letter.downcase == 'c' && @grid[2][5].empty?
        @pick = 2
      elsif letter.downcase == 'd' && @grid[3][5].empty?
        @pick = 3
      elsif letter.downcase == 'e' && @grid[4][5].empty?
        @pick = 4
      elsif letter.downcase == 'f' && @grid[5][5].empty?
        @pick = 5
      elsif letter.downcase == 'g' && @grid[6][5].empty?
        @pick = 6
      else
        puts "\e[H\e[2J"
        @board.render("\nInvalid input, try again.")
        prompt
      end
    end
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