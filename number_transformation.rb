def to_roman(num)
  symbols = Array["I", "V", "X", "L", "C", "D", "M"]
  result = ""
  (0..num.length - 1).each { |i|
    pos = 2 * (num.length - (i + 1))
    case num[i]
    when "1"
      result.concat(symbols[pos])
    when "2"
      result.concat(symbols[pos])
      result.concat(symbols[pos])
    when "3"
      result.concat(symbols[pos])
      result.concat(symbols[pos])
      result.concat(symbols[pos])
    when "4"
      result.concat(symbols[pos])
      result.concat(symbols[pos + 1])
    when "5"
      result.concat(symbols[pos + 1])
    when "6"
      result.concat(symbols[pos + 1])
      result.concat(symbols[pos])
    when "7"
      result.concat(symbols[pos + 1])
      result.concat(symbols[pos])
      result.concat(symbols[pos])
    when "8"
      result.concat(symbols[pos + 1])
      result.concat(symbols[pos])
      result.concat(symbols[pos])
      result.concat(symbols[pos])
    when "9"
      result.concat(symbols[pos])
      result.concat(symbols[pos + 2])
    end
  }
  result
end

def to_arabic(num)
  symbols = Array["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
  result = 0
  skip = false
  (0..num.length - 1).each { |i|
    if skip
      skip = false
      next
    end
    case num[i]
    when "M"
      result = result + 1000
    when "D"
      result = result + 500
    when "C"
      if num[i + 1] == "M"
        result = result + 900
        skip = true
      elsif num[i + 1] == "D"
        result = result + 400
        skip = true
      else
        result = result + 100
      end
    when "L"
      result = result + 50
    when "X"
      if num[i + 1] == "C"
        result = result + 90
        skip = true
      elsif num[i + 1] == "L"
        result = result + 40
        skip = true
      else
        result = result + 10
      end
    when "V"
      result = result + 5
    when "I"
      if num[i + 1] == "X"
        result = result + 9
        skip = true
      elsif num[i + 1] == "V"
        result = result + 4
        skip = true
      else
        result = result + 1
      end
    else
      result = 4000
      break
    end
  }
  result
end

loop do
  puts "0 - Input an arabic numeral\n1 - Input a roman numeral"
  check = gets.chomp.strip.to_i
  if check < 0 or check > 1
    break
  end
  if check == 0
    puts "Value of the number?"
    num_ar = gets.chomp.strip.to_i
    while num_ar < 1 or num_ar >= 4000
      puts "Number out of bounds."
      num_ar = gets.chomp.strip.to_i
    end
    puts "Value of the arabic number in roman system: #{to_roman(num_ar.to_s)}."
  elsif check == 1
    puts "Value of the number?"
    num_rom = gets.chomp.strip.to_s.upcase
    while to_arabic(num_rom) < 1 or to_arabic(num_rom) >= 4000
      puts "Number out of bounds."
      num_rom = gets.chomp.strip.to_s.upcase
    end
    puts "Value of the roman number in arabic system: #{to_arabic(num_rom)}."
  end
end
