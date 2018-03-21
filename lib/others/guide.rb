#!/usr/bin/env ruby

# ruby perfect guide

module M1
  def hello
    p 'this is M1'
  end
end

module M2
  def hello
    p 'this is M2'
  end
end

class C
  include M1
  include M2

  def caller
    hello # call M2::hello
  end
end

c_sin = C.new

# 特異メソッド(a.k.a. singleton method)
def c_sin.my_hello
  p 'this is singleton method'
end

if __FILE__ == $0
  c = C.new

  c.caller

  c_sin.my_hello
end
