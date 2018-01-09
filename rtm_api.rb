require 'net/http'
require 'json'
require 'uri'

url = URI.parse('https://api.rememberthemilk.com/services/rest/')
req = Net::HTTP::Post.new(url.request_uri)
req.set_form_data({auth_token: '1bde5e2d43e8bd11d605081d1347c64272823ffa', method: 'rtm.tasks.getList', format: 'json'})

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = (url.scheme == 'https')

res = http.request(req)

p res
p res.body

