def abbreviate(abbr_arr)
  abbreviated = ""
  (0.. abbr_arr.length - 1).each { |i|
    abbr_arr[i].capitalize!
    abbreviated.concat(abbr_arr[i][0])
  }
  abbreviated
end

puts "String to be abbreviated?"
abbreviated = gets.chomp.strip.to_s
abbr_arr = abbreviated.split(/ /)
puts abbreviate(abbr_arr)