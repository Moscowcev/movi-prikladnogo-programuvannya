mutex = Mutex.new
opening = ConditionVariable.new
thread1 = Thread.new {
  mutex.synchronize {
    opening.signal
    (1..10).each do |i|
      opening.wait(mutex)
      puts "Thread1: " + i.to_s
      opening.signal
    end
  }
}
thread2 = Thread.new {
  mutex.synchronize {
    opening.signal
    (1..10).each do |i|
      opening.wait(mutex)
      puts "Thread2: " + i.to_s
      opening.signal
    end
  }
}
thread1.join
thread2.join