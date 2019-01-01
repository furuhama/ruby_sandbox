require 'benchmark'

def fib(n)
  return 1 if n <= 1

  fib(n-1) + fib(n-2)
end

Benchmark.bm 10 do |bm|
  bm.report 'pure Ruby' do
    fib(40)
  end
end
