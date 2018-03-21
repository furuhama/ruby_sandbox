require 'net/http'
require 'json'
require 'uri'

url = URI.parse('https://www.rememberthemilk.com/services/auth/')
req = Net::HTTP::Post.new(url.request_uri)
req.set_form_data({api_key: '6e6c4c1b71f816a5674596901a48616a', perms: 'delete', api_sig: 'dce1de62a7f25e407bca9b303b395a5a'})

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = (url.scheme == 'https')

res = http.request(req)

p res
p res.body

