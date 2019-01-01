require 'benchmark'
require 'ffi'

module Fib
  extend FFI::Library

  ffi_lib 'libfib.dylib'

  attach_function :fib, %i[int], :int
end

def fib(n)
  return 1 if n <= 1

  fib(n-1) + fib(n-2)
end

Benchmark.bm 15 do |bm|
  bm.report 'pure Ruby' do
    fib(40)
  end
  bm.report 'Rust from Ruby' do
    Fib.fib(40)
  end
end
