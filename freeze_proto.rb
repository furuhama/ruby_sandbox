# prototype of freeze

class Array
  def <<(fn)
    fn = fn.to_sym if fn.class == String
    self.map(&fn)
    self.send(fn)
  end
end

a = [1, 2, 3, 4]
a << :freeze
puts 'set :freeze'
puts a.frozen?
puts a[0].frozen?

b = [100, 'hoge', [1, 2], true]
b << 'freeze'
puts 'set freeze(String)'
puts b.frozen?
puts b[0].frozen?
