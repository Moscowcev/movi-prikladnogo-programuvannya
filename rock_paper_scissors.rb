moves = Array["Rock", "Paper", "Scissors"]
rock_results = {
  "Rock" => "It's a draw!",
  "Paper" => "Player 2 wins!",
  "Scissors" => "Player 1 wins!"
}
paper_results = {
  "Rock" => "Player 1 wins!",
  "Paper" => "It's a draw!",
  "Scissors" => "Player 2 wins!"
}
scissors_results = {
  "Rock" => "Player 2 wins!",
  "Paper" => "Player 1 wins!",
  "Scissors" => "It's a draw!"
}
loop do
  puts "Move of Player 1?"
  move_1 = gets.chomp
  move_1 = move_1.strip
  move_1 = move_1.downcase
  move_1 = move_1.capitalize
  puts "Move of Player 2?"
  move_2 = gets.chomp
  move_2 = move_2.strip
  move_2 = move_2.downcase
  move_2 = move_2.capitalize
  if not moves.include?(move_1) or not moves.include?(move_2)
    puts "Unsanctioned move."
    break
  end
  if move_1 == moves[0]
    puts rock_results[move_2]
  elsif move_1 == moves[1]
    puts paper_results[move_2]
  elsif move_1 == moves[2]
    puts scissors_results[move_2]
  end
end