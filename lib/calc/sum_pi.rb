""" get Pi """

def sum_pi(n)
  total, k = 0.0, 1.0
  while k <= n do
    total += (8 / ((4.0 * k - 3.0) * (4.0 * k - 1.0))).to_f
    k += 1.0
  end
  return total
end

p sum_pi(100)