require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("https://api.justyo.co/yos")

header = {'Content-Type': 'text/json'}

# username: target username
# access_token: account that send yo
payload = {
  username: 'FURUHAMA',
  text: 'search your next class',
  access_token: 'c1cf637d-418d-4a94-8cb0-e27e41e01a0e'
  }

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = payload.to_json

# Send the request
response = http.request(request)
