module Prompter
  def clear
    puts "\e[H\e[2J"
  end

  def playorquit
    puts "Enter p to play, or q to quit!\n"
    if @winner
      puts "Enter s to select players, and r to reset all!"
    end
    answer = gets.chomp.downcase
    case answer
    when 'p'
      if @winner
        play
      else
        humans_or_computers
      end
    when 'q'
      clear 
      abort("See you next time!")
    when 'r'
      @wins, @losses, @draws = 0, 0, 0
      @winner = false
      humans_or_computers
    when 's'
      humans_or_computers
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
    [@player1, @player2].each do |player|
      clear 
      puts question = "Is player \"#{player.letter}\" a human or a computer?\n(h, c)"
      answer = gets.chomp.downcase
      until ['h', 'c'].include?(answer)
        clear
        puts question
        answer = gets.chomp.downcase
      end
      case answer
        when 'h'
          player.type = 'h'
        when 'c'
          player.type = 'c'
          player.difficulty = selectdifficulty
      end
    end
    sleep(1.25)
    puts "\nGood luck, have fun! Let the connex commence!"
    sleep(1.25)
    play
  end
  
  def selectdifficulty
    clear
    puts question = "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
    answer = gets.chomp.downcase
    until ['e', 'm', 'h', 'i'].include?(answer)
      clear
      puts question
      answer = gets.chomp.downcase
    end
    clear
    case answer
      when 'e'
        puts "You chose Easy!"
      when 'm' 
        puts "You chose Medium!"
      when 'h'
        puts "You chose HARD!!"
      when 'i'
        puts "Who told you about Insane mode?!"
      end
    answer
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
end
