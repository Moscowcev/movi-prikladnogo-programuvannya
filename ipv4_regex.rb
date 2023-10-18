def ipv4_match(address)
  address.match(/^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/)
end

loop do
  address = gets
  if address.empty?
    break
  end
  if ipv4_match(address)
    puts "The string fits the IPv4 format."
  else
    puts "The string does not fit the IPv4 format."
  end
end