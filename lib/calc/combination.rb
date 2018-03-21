# compute the total possibility of trials

def comb(n, k)
  numer = (n-k+1..n).inject(1, &:*)
  denom = (1..k).inject(1, &:*)
  numer / denom
end

# possibility: 1.5 %
# the number of trials: 2140
# maximum number of positive trial: 21

NUM_TRIALS = 2140
POSSIBILITY = Rational(15, 1000)
RANGE = (0..21)

result = 0
NUM_TRIALS.times do |n|
  next unless RANGE.include?(n)
  result += comb(NUM_TRIALS, n) * (POSSIBILITY ** n) * ((1 - POSSIBILITY) ** (NUM_TRIALS - n))
end

puts "result: #{result.to_f * 100} %"
