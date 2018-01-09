require 'net/http'
require 'uri'

url = URI.parse('http://localhost:3001')
res = Net::HTTP.start(url.host, url.port) do |http|
  http.get('/')
end

puts res
res.each_header do |name, val|
  puts "name=#{name}, val=#{val}"
end
