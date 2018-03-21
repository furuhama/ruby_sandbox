require 'net/http'
require 'uri'

url = URI.parse('http://localhost:3001/')

# just send POST request
res = Net::HTTP.post_form(url, {'q' => 'ruby'})
puts res.body

# details
req = Net::HTTP::Post.new(url.path)
req.set_form_data({'from' => '2005-01-01', 'to' => '2010-01-01'}, ';')
res = Net::HTTP.new(url.host, url.port).start do |http|
  http.request(req)
end

puts res.code
puts res.body
