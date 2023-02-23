module Prompter
  def clear
    puts "\e[H\e[2J"
  end

  def prompt
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }.freeze
    loop do
      print "\nEnter A-G to place your X, or R for random!\n"
      # print "or \"check\" to test your move!\n"
      answer = gets.chomp.downcase
      if columns.key?(answer) && @grid[columns[answer]][5].empty?
        return columns[answer]
      elsif answer == 'r'
        col = nil
        loop do 
          col = rand(0..6)
          node = @grid[col].find{|node| node.empty?}
          break if node
        end
        return col
      else
        clear
        @board.render
      end
    end
  end

  def playorquit
    puts "Enter p to play, or q to quit!\n"
    answer = gets.chomp.downcase
    case answer
    when 'p'
      humans_or_computers
    when 'q'
      clear 
      abort("See you next time!")
    else
      if !@under
        clear
        @board.render("...oh SNAP! #{@message} Good game!")
        playorquit
      else
        start
      end
    end
  end
  
  def humans_or_computers
    clear 
    puts "Is player ONE a human or a computer?\n(h, c)"
    p1 = gets.chomp.downcase
    case p1
    when 'h'
      @player1.type = 'h'
    when 'c'
      @player1.type = 'c'
      @player1.difficulty = selectdifficulty
    else
      humans_or_computers
    end
    @player1.change_letter('X')
  
    clear
    puts "Is player TWO a human or a computer?\n(h, c)"
    p2 = gets.chomp.downcase
    case p2
    when 'h'
      @player2.type = 'h'
    when 'c'
      @player2.type = 'c'
      @player2.difficulty = selectdifficulty
    else
      humans_or_computers
    end
    @player2.change_letter('O')
  
    sleep(1.5)
    puts "\nGood luck, have fun! Let the games begin!"
    sleep(1.5)
    play
  end
  
  def selectdifficulty
    valid_inputs = ['e', 'm', 'h', 'i']
    
    clear
    puts "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
    answer = gets.chomp.downcase
    until valid_inputs.include?(answer)
      clear
      puts "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
      answer = gets.chomp.downcase
    end

    case answer
    when 'e'
      clear
      puts "You chose Easy!"
    when 'm' 
      clear
      puts "You chose Medium!"
    when 'h'
      clear
      puts "You chose HARD!!"
    when 'i'
      clear
      puts "Who told you about Insane mode?!"
    end
    answer
  end
end
