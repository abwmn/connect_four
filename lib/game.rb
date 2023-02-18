require_relative 'board'

class Game
  attr_reader :board
  def initialize
    @board = board
  end

  def start
    puts "Welcome to Connect 4!\n Enter p to play, or q to quit!"
    if self.gets("p") || self.gets("P")
      puts "Let the games begin!"
      self.play
    elsif self.gets("q") || self.gets("Q")
      puts "See you next time!"
    else
      puts "Play or quit?"
      start
    end
  end

  def game_over
    false
  end
  
  def play
    @board = Board.new
    until game_over 
      @board.render
      puts "Place your X!"
      if gets "a" || "A"
        board.places(0,"X")
      elsif gets "b" || "B"
        board.places(1,"X")
      elsif gets "c" || "C"
        board.places(2,"X")
      elsif gets "d" || "D"
        board.places(3,"X")
      elsif gets "e" || "E"
        board.places(4,"X")
      elsif gets "f" || "F"
        board.places(5,"X")
      elsif gets "g" || "G"
        board.places(6,"X")
      else 
        puts "Invalid input"
        play
      end
      board.places("O")
    end
  end
end