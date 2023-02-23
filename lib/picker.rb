require_relative 'requirements'
module Picker
  def pick(player)
    case player.letter
    when 'X'
      other_letter = 'O'
    when 'O'
      other_letter = 'X'
    end
    case player.difficulty
    when 'e'
      easy_pick
    when 'm'
      medium_pick(player.letter, other_letter)
    when 'h'
      hard_pick(player.letter, other_letter)
    when 'i'
      insane_pick(player.letter, other_letter)
    end
  end
  
  def easy_pick
    col = 10
    loop do
      col = rand(0..6)
      node = @grid[col].find {|node| node.empty? }
      break if node
    end
    col
  end

  def medium_pick(letter, other_letter)
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, letter)
        return col
      elsif node && node.connect?(4, other_letter)
        movescores[col] = 2
      elsif node
        movescores[col] = 1
      else
        movescores[col] = 0
      end
    end
    movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
  end

  def hard_pick(letter, other_letter)
    return rand(0..6) if @moves < 4
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, letter)
        return col
      elsif node && node.connect?(4, other_letter)
        movescores[col] = 4
      elsif node && node.connect?(3, letter)
        if !node.n && node.count('s', letter) == 2
          movescores[col] = 1
        else  
          movescores[col] = 3
        end
      elsif node
        movescores[col] = node.connect(letter)
      else
        movescores[col] = 0
      end
    end 
    movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
  end

  def insane_pick(letter, other_letter)
    return rand(0..6) if @moves < 2
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, letter)
        return col
      elsif node && node.connect?(4, other_letter)
        if node.any_traps?(letter)
          movescores[col] = 6
        else
          movescores[col] = 5
        end
      elsif node && node.connect?(3, letter)
        if !node.n && node.count('s', letter) == 2
          movescores[col] = 1
        else
          movescores[col] = 3
        end
        if node.any_traps?(letter)
          movescores[col] = 4
        end
      elsif node
        movescores[col] = node.connect(letter)
      else
        movescores[col] = 0
      end
    end 
    movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
  end
end