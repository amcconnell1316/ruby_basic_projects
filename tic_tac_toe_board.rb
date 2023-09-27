class Board
  def initialize
    @spots = Array.new(3) {Array.new(3, 0)}
    @spots[0][0] = -1
    @spots[1][1] = -1
    #@spots[2][2] = -1
  end

  def play_turn(player_symbol, spot)
    spot_downcase = spot.downcase
    return "player must be x or o" if !(player_symbol == "x" || player_symbol == "o")
    return "invaild spot" if !(spot_downcase.include?("a") || spot_downcase.include?("b") || spot_downcase.include?("c"))
    return "invaild spot" if !(spot_downcase.include?("1") || spot_downcase.include?("2") || spot_downcase.include?("3"))
    case player_symbol
    when "x"
      player = -1
    when "o"
      player = 0
    end
    if spot_downcase.include?("1") 
      row = 0
    elsif spot_downcase.include?("2") 
      row = 1
    else 
      row = 2
    end
    if spot_downcase.include?("a") 
      col = 0
    elsif spot_downcase.include?("b") 
      col = 1
    else 
      col = 2
    end
    
    @spots[row][col] = player
    nil
  end

  def print_board
    puts "  A B C "
    @spots.each_with_index do |row, i|
      row_string = "#{i+1}|"
      row.each do |spot|
        row_string += display_spot(spot)
        row_string += "|"
      end
      puts row_string
    end
  end

  def check_winner
    win_conditions = Array.new
    win_conditions << @spots[0][0] + @spots[0][1] + @spots[0][2] # row 1
    win_conditions << @spots[1][0] + @spots[1][1] + @spots[1][2] # row 2
    win_conditions << @spots[2][0] + @spots[2][1] + @spots[2][2] # row 3
    win_conditions << @spots[0][0] + @spots[1][0] + @spots[2][0] # col A
    win_conditions << @spots[0][1] + @spots[1][1] + @spots[2][1] # col B
    win_conditions << @spots[0][2] + @spots[1][2] + @spots[2][2] # col C
    win_conditions << @spots[0][2] + @spots[1][1] + @spots[2][0] # diagonal /
    win_conditions << @spots[0][0] + @spots[1][1] + @spots[2][2] # diagonal \
    return 1 if win_conditions.max == 3 
    return -1 if win_conditions.min == -3
    0
  end

  private
  def display_spot(spot)
    case spot
      when 0 then " "
      when -1 then "x"
      when 1 then "o"
    end
  end
end

test = Board.new
test.print_board
test.play_turn("x", "c3")
test.print_board
puts test.check_winner