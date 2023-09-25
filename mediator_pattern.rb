$fuel_capacity = 60
$staff_capacity = 10

class Military_Base

  attr_reader :vehicles
  attr_reader :canister
  attr_reader :warehouse

  def initialize
    @vehicles = []
    @canister = Canister.new
    @warehouse = Warehouse.new
  end

  def move(vehicle)
    if @vehicles.include?(vehicle)
      if @canister.fuel > 0 and @warehouse.staff > 0
        if $fuel_capacity > @canister.fuel
          vehicle.fuel = @canister.fuel
          @canister.fuel = 0
        elsif $fuel_capacity < @canister.fuel
          vehicle.fuel = $fuel_capacity
          @canister.fuel = @canister.fuel - $fuel_capacity
        end
        if $staff_capacity > @warehouse.staff
          vehicle.staff = @warehouse.staff
          @warehouse.staff = 0
        elsif $staff_capacity < @warehouse.staff
          vehicle.staff = $staff_capacity
          @warehouse.staff = @warehouse.staff - $staff_capacity
        end
        @warehouse.capacity += 1
        @vehicles.delete(vehicle)
        return "Truck departed."
      else
        return "Truck not prepared to drive."
      end
    else
      if @warehouse.capacity > 0
        @canister.fuel = @canister.fuel + vehicle.fuel
        vehicle.fuel = 0
        @warehouse.staff = @warehouse.staff + vehicle.staff
        vehicle.staff = 0
        @warehouse.capacity = @warehouse.capacity - 1
        @vehicles.push(vehicle)
        return "Truck arrived."
      else
        return "Base can't accommodate more trucks."
      end
    end
  end

end

class Truck

  attr_accessor :fuel
  attr_accessor :staff
  attr_accessor :mediator

  def initialize(fuel = rand($fuel_capacity), staff = rand($staff_capacity), mediator = Military_Base.new)
    @fuel = fuel
    @staff = staff
    @mediator = mediator
  end

  def drive
    mediator.move(self)
  end

end

class Canister

  attr_accessor :fuel

  def initialize(fuel = 600)
    @fuel = fuel
  end

end

class Warehouse

  attr_accessor :capacity
  attr_accessor :staff

  def initialize(capacity = 10, staff = 40)
    @capacity = capacity
    @staff = staff
  end

end

trucks = Array[]
mediator = Military_Base.new
loop do
  puts "1 - Create a new truck\n2 - Move a truck to/from base\n3 - List trucks\n4 - List base conditions\n5 - Finish application"
  input = gets.chomp.strip.to_i
  case input
  when 1
    puts "Amount of fuel in the truck?"
    id_1 = gets.chomp.strip.to_i
    while id_1 <= 0
      puts "State an appropriate amount."
      id_1 = gets.chomp.strip.to_i
    end
    puts "Amount of people in the truck?"
    id_2 = gets.chomp.strip.to_i
    while id_2 <= 0
      puts "State an appropriate amount."
      id_2 = gets.chomp.strip.to_i
    end
    trucks.push(Truck.new(id_1, id_2, mediator))
  when 2
    puts "Which truck to move?"
    id_1 = gets.chomp.strip.to_i
    while id_1 < 0 or id_1 >= trucks.length
      puts "State an appropriate amount."
      id_1 = gets.chomp.strip.to_i
    end
    puts trucks[id_1].drive
  when 3
    (0..trucks.length - 1).each { |i|
      puts "Truck ##{i}:\nFuel: #{trucks[i].fuel} liters\nPassengers: #{trucks[i].staff}\nParked? #{mediator.vehicles.include?(trucks[i])}"
    }
  when 4
    puts "Fuel on base: #{mediator.canister.fuel} liters\nStaff on base: #{mediator.warehouse.staff}\nSpace left: #{mediator.warehouse.capacity}"
  when 5
    break
  else
    puts "Incorrect input."
  end
end