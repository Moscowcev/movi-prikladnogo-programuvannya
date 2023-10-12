def cut?(cake, order, pieces, forms)
  temp = Array.new
  (0..cake.length - 1).each { |i|
    temp.push("")
    (0..cake[i].length - 1).each { |j|
      temp[i].concat(cake[i][j])
    }
  }
  order = order + 1
  start_points = Array.new
  pieces.push(Array.new)
  result = false
  (0..5).each { |i|
    (0..9).each { |j|
      if temp[i][j] != "," and temp[i][j] != "O"
        if i == 0
          if j == 0
            start_points.push(Array[i,j])
          elsif temp[i][j - 1] == "," or temp[i][j - 1] == "O"
            start_points.push(Array[i,j])
          end
        else
          if j == 0
            if temp[i - 1][j] == "," or temp[i - 1][j] == "O"
              start_points.push(Array[i,j])
            end
          elsif (temp[i - 1][j] == "," or temp[i - 1][j] == "O") and (temp[i][j - 1] == "," or temp[i][j - 1] == "O")
            start_points.push(Array[i,j])
          end
        end
      end
    }
  }
  (0..start_points.length - 1).each { |i|
    (0..forms.length - 1).each { |j|
      temp = Array.new
      (0..cake.length - 1).each { |i|
        temp.push("")
        (0..cake[i].length - 1).each { |j|
          temp[i].concat(cake[i][j])
        }
      }
      raisin = false
      cuttable = true
      if start_points[i][0] + forms[j][0] <= 6 and start_points[i][1] + forms[j][1] <= 10
        (start_points[i][0]..start_points[i][0] + forms[j][0] - 1).each { |k|
          (start_points[i][1]..start_points[i][1] + forms[j][1] - 1).each { |n|
            if temp[k][n] == "," or temp[k][n] == "O"
              cuttable = false
            elsif temp[k][n] == "o" and raisin
              cuttable = false
            elsif temp[k][n] == "o" and !raisin
              raisin = true
            end
          }
        }
      else
        cuttable = false
      end
      if !raisin
        cuttable = false
      end
      if cuttable
        (start_points[i][0]..start_points[i][0] + forms[j][0] - 1).each { |k|
          (start_points[i][1]..start_points[i][1] + forms[j][1] - 1).each { |n|
            if temp[k][n] == "."
              temp[k][n] = ","
            elsif temp[k][n] == "o"
              temp[k][n] = "O"
            end
          }
        }
        done = true
        (0..5).each { |k|
          (0..9).each { |n|
            if temp[k][n] != "," and temp[k][n] != "O"
              done = false
            end
          }
        }
        if done
          result = true
        elsif order < 6
          copy = Array.new
          (0..temp.length - 1).each { |i|
            copy.push("")
            (0..temp[i].length - 1).each { |j|
              copy[i].concat(temp[i][j])
            }
          }
          depth = order
          result = cut?(copy, depth, pieces, forms)
        end
        if result
          piece = Array.new
          (start_points[i][0]..start_points[i][0] + forms[j][0] - 1).each { |k|
            piece.push("")
            (start_points[i][1]..start_points[i][1] + forms[j][1] - 1).each { |n|
              if temp[k][n] == "." or temp[k][n] == ","
                piece[piece.length - 1].concat(".")
              elsif temp[k][n] == "o" or temp[k][n] == "O"
                piece[piece.length - 1].concat("o")
              end
            }
          }
          pieces[order - 1] = piece
          break
        end
      end
    }
    if result
      break
    end
  }
  if !result
    pieces.pop
  end
  result
end

loop do
  cake = Array.new
  (0..5).each { |i|
    cake.push("")
    (0..9).each {
      cake[i] << "."
    }
  }
  puts "Amount of raisins? (1-6)"
  amount = gets.chomp.strip.to_i
  if amount < 1 or amount > 6
    break
  end
  puts "0 - Distribute raisins automatically\n1 - Distribute raisins manually"
  check = gets.chomp.strip.to_i
  while check < 0 or check > 1
    puts "Incorrect choice."
    check = gets.chomp.strip.to_i
  end
  if check == 0
    taken = Array.new
    temp = 0
    while temp < amount
      pos1 = rand(6)
      pos2 = rand(10)
      while taken.include? Array[pos1, pos2]
        pos1 = rand(6)
        pos2 = rand(10)
      end
      taken[temp] = Array.new
      taken[temp][0] = pos1
      taken[temp][1] = pos2
      cake[pos1][pos2] = "o"
      temp = temp + 1
    end
  else
    taken = Array.new
    temp = 0
    while temp < amount
      puts "Line of the changed element? (0-5)"
      pos1 = gets.chomp.strip.to_i
      while pos1 < 0 or pos1 > 5
        puts "Incorrect choice."
        pos1 = gets.chomp.strip.to_i
      end
      puts "Column of the changed element? (0-9)"
      pos2 = gets.chomp.strip.to_i
      while pos2 < 0 or pos2 > 9
        puts "Incorrect choice."
        pos2 = gets.chomp.strip.to_i
      end
      while taken.include? Array[pos1, pos2]
        puts "Position already taken."
        puts "Line of the changed element? (0-5)"
        pos1 = gets.chomp.strip.to_i
        while pos1 < 0 or pos1 > 5
          puts "Out of bounds."
          pos1 = gets.chomp.strip.to_i
        end
        puts "Column of the changed element? (0-9)"
        pos2 = gets.chomp.strip.to_i
        while pos2 < 0 or pos2 > 9
          puts "Out of bounds."
          pos2 = gets.chomp.strip.to_i
        end
      end
      taken[temp] = Array.new
      taken[temp][0] = pos1
      taken[temp][1] = pos2
      cake[pos1][pos2] = "o"
      temp = temp + 1
    end
  end
  puts "Cake appearance:"
  puts cake
  pieces = Array.new
  forms = Array.new
  case amount
  when 1
    forms.push(Array[6, 10])
  when 2
    forms.push(Array[3, 10])
    forms.push(Array[6, 5])
  when 3
    forms.push(Array[2, 10])
    forms.push(Array[4, 5])
  when 4
    forms.push(Array[3, 5])
  when 5
    forms.push(Array[2, 6])
    forms.push(Array[3, 4])
    forms.push(Array[4, 3])
    forms.push(Array[6, 2])
  when 6
    forms.push(Array[1, 10])
    forms.push(Array[2, 5])
    forms.push(Array[5, 2])
  end
  if cut? cake, 0, pieces, forms
    puts "["
    (0..pieces.length - 1).each { |i|
      (0..pieces[i].length - 1).each { |j|
        puts "#{pieces[i][j]}"
      }
      puts ",\n"
    }
    puts "]"
  else
    puts "Impossible to divide cake under current raisin placement."
  end
end