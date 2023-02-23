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

  def humans_or_computers
    clear 
    puts "Is player ONE a human or a computer?\n(h, c)"
    answer = gets.chr.downcase
    if answer == 'h'
      @player1 = Human.new
    elsif answer == 'c'
      @player1 = Computer.new
      selectdifficulty(@player1)
    else
      humans_or_computers
    end
    @player1.change_letter('X')
    clear
    puts "Is player TWO a human or a computer?\n(h, c)"
    answer = gets.chr.downcase
    if answer == 'h'
      @player2 = Human.new
    elsif answer == 'c'
      @player2 = Computer.new
      selectdifficulty(@player2)
    else
      humans_or_computers
    end
    @player2.change_letter('O')
    sleep(1.5)
    puts "\nGood luck, have fun! Let the games begin!"
    sleep(1.5)
    play
  end

  # def get_player(player, letter)
  #   answer = gets.chr.downcase
  #   if answer == 'h'
  #     player = Human.new
  #   elsif answer == 'c'
  #     player = Computer.new
  #     selectdifficulty(player)
  #   else
  #     humans_or_computers
  #   end
  #   player.change_letter(letter)
  # end

  def playorquit
    loop do
      puts "\nEnter p to play, or q to quit!\n"
      case answer = gets.chr.downcase
      when 'p'
        humans_or_computers
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

  def selectdifficulty(player)
    clear
    puts "Please select difficulty!\nEasy, Medium, or HARD\n(e, m, h)"
    case answer = gets.chr.downcase
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
      puts "Who told you about the Insane difficulty?!"
    else
      selectdifficulty(player)
    end
    player.difficulty = answer
  end
end
