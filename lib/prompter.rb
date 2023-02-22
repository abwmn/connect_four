module Prompter
  def playorquit
    loop do
      puts "\nEnter p to play, or q to quit!\n"
      case answer = gets.chr.downcase
      when 'p'
        selectdifficulty
      when 'q'
        clear 
        abort("See you next time!")
      else
        if !@under
          clear
          @board.render("\noh SNAP! #{@message}\n")
        else
          start
        end
      end
    end
  end

  def selectdifficulty
    clear
    puts "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
    answer = gets.chr.downcase
    msg = case answer
    when'e'
      "You chose Easy!"
    when 'm' 
      "You chose Medium!"
    when 'h'
      "You chose HARD!!"
    when 'i'
      "Who told you about the Insane difficulty?!"
    else
      selectdifficulty
    end
    @difficulty = answer
    clear
    puts msg
    puts "\nGood luck, have fun! Let the games begin!"
    sleep(1.5)
    play
  end

  def prompt
    columns = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6 }.freeze
    loop do
      print "\nEnter A-G to place your X, or R for random!\n"
      # print "or \"check\" to test your move!\n"
      pick = gets.chomp.downcase
      if columns.key?(pick) && @grid[columns[pick]][5].empty?
        return columns[pick]
      elsif pick == 'r'
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
  
  def clear
    puts "\e[H\e[2J"
  end
end