def count(coins, sum)
  solutions = Array.new
  (0..coins.length - 1).each do |i|
    solutions.push(Array.new)
    (0..sum).each do |j|
      if i == 0
        solutions[i][j] = coins[i] * j
      elsif coins[i] > j
        solutions[i][j] = solutions[i-1][j]
      else
        solutions[i][j] = [solutions[i][j - coins[i]] + 1, solutions[i-1][j]].min
      end
    end
  end
  solutions[coins.length - 1][sum]
end

loop do
  coins = Array.new
  puts "List coin denominations (0 input -> Stop):"
  input = gets.chomp.strip.to_i
  while input > 0
    coins.push(input)
    input = gets.chomp.strip.to_i
  end
  coins.sort!
  if coins[0] != 1
    coins.insert(0, 1)
  end
  puts "Overall sum of money in coins (less than 0 -> program end)?"
  sum = gets.chomp.strip.to_i
  if sum < 0
    break
  end
  minimum = count(coins, sum)
  puts "Minimum number of coins from set denominations to fit the established sum = #{minimum}"
end