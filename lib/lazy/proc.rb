a, b = 0, 1

fib = Proc.new do
  a, b = b, a + b

  a
end

10.times do
  puts fib.call

  sleep 1
end
