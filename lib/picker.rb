module Picker
  def pick
    case @difficulty
    when 'e'
      easy_pick
    when 'm'
      medium_pick
    when 'h'
      hard_pick
    when 'i'
      insane_pick
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

  def medium_pick
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, 'O')
        return col
      elsif node && node.connect?(4, 'X')
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

  def hard_pick
    return rand(0..6) if @moves < 4
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, 'O')
        return col
      elsif node && node.connect?(4, 'X')
        movescores[col] = 4
      elsif node && node.connect?(3, 'O')
        if !node.n && node.count('s', 'O') == 2
          movescores[col] = 1
        else  
          movescores[col] = 3
        end
      elsif node
        movescores[col] = node.connect('O')
      else
        movescores[col] = 0
      end
    end 
    movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
  end

  def insane_pick
    return rand(0..6) if @moves < 2
    movescores = {}
    (0..6).each do |col|
      node = @grid[col].find { |node| node.empty?}
      if node && node.connect?(4, 'O')
        return col
      elsif node && node.connect?(4, 'X')
        if node.any_traps?('O')
          movescores[col] = 6
        else
          movescores[col] = 5
        end
      elsif node && node.connect?(3, 'O')
        if !node.n && node.count('s', 'O') == 2
          movescores[col] = 1
        else
          movescores[col] = 3
        end
        if node.any_traps?('O')
          movescores[col] = 4
        end
      elsif node
        movescores[col] = node.connect('O')
      else
        movescores[col] = 0
      end
    end 
    movescores.keys.find_all do |key| 
      movescores[key] == movescores.values.max
    end.sample 
  end
end