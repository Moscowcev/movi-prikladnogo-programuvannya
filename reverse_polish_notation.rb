$numbers = Array["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
$operators_low = Array["+", "-"]
$operators_high = Array["*", "/", "%"]

def rpn(input)
  operators = Array.new
  output = ""
  if input.empty?
    puts "Flawed equation."
    return
  end
  i = 0
  while i < input.size
    if $numbers.include?(input[i])
      output += " "
      output += input[i]
    elsif input[i] == "*" and input[i+1] == "*"
      operators.push(input[i]+input[i+1])
      i += 1
    elsif $operators_low.include?(input[i])
      while !operators.empty? and operators.last != "("
        output += " "
        output += operators.pop
      end
      operators.push(input[i])
    elsif $operators_high.include?(input[i])
      while !operators.empty? and operators.last != "(" and !$operators_low.include?(operators.last)
        output += " "
        output += operators.pop
      end
      operators.push(input[i])
    elsif input[i] == "("
      operators.push(input[i])
    elsif input[i] == ")"
      while !operators.empty? and operators.last != "("
        output += " "
        output += operators.pop
      end
      if operators[-1] == "("
        operators.pop
      end
    elsif input[i] == "," or input[i] == "."
      output += input[i]
    elsif input[i] != " "
      puts "Flawed equation."
      return
    end
    i += 1
  end
  while !operators.empty?
    output += " "
    output += operators.pop
  end
  output.strip
end

loop do
  puts "Your equation?"
  input = gets.chomp.strip.split(//)
  output = rpn input
  if output == nil
    break
  end
  puts output
end