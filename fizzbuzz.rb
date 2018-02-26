# fizzbuzz by functional way

class FizzBuzz
  def self.to_proc
    # `->n{` is ok as well
    lambda { |n|
      case n % 15
      when 0 then :FizBuzz
      when 3, 6, 9, 12 then :Fizz
      when 5, 10 then :Buzz
      else n
      end
    }
  end
end

if __FILE__ == $0

  puts (1..10_000_000).map(&FizzBuzz)

end
