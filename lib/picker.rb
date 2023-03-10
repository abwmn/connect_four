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
    col = nil
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
    hardscores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, letter)
        hardscores[col] = 5
      elsif node && node.connect?(4, other_letter)
        hardscores[col] = 4
      elsif node && node.connect?(3, letter)
        if !node.n && node.count('s', letter) == 2
          hardscores[col] = 1
        else  
          hardscores[col] = 3
        end
      elsif node
        hardscores[col] = node.connect(letter)
      else
        hardscores[col] = 0
      end
    end 
    hardscores.keys.find_all do |key| 
      hardscores[key] == hardscores.values.max
    end.sample 
  end

  def insane_pick(letter, other_letter)
    return rand(0..6) if @moves < 2
    insanescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, letter)
        return col
      elsif node && node.connect?(4, other_letter)
        if node.any_traps?(letter)
          insanescores[col] = 6
        else
          insanescores[col] = 5
        end
      elsif node && node.connect?(3, letter)
        if !node.n && node.count('s', letter) == 2
          insanescores[col] = 1
        else
          insanescores[col] = 3
        end
        if node.any_traps?(letter)
          insanescores[col] = 4
        end
        node.letter = letter
        if @grid[hard_pick(other_letter, letter)].find{|node|node.empty?}&.connect?(4, other_letter)
          insanescores[col] = 0.5
        end
        node.letter = '.'
      elsif node
        insanescores[col] = node.connect(letter)
        node.letter = letter
        if @grid[hard_pick(other_letter, letter)].find{|node|node.empty?}&.connect?(4, other_letter)
          insanescores[col] = 0.5
        end
        node.letter = '.'
      else
        insanescores[col] = 0
      end
    end 
    insanescores.keys.find_all do |key| 
      insanescores[key] == insanescores.values.max
    end.sample 
  end
end