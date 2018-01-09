require 'milkman'
require 'json'

client = Milkman::Client.new(api_key: '6e6c4c1b71f816a5674596901a48616a', shared_secret: '3e9b178cd216f46d', auth_token: '1bde5e2d43e8bd11d605081d1347c64272823ffa')

res = client.get('rtm.tasks.getList')
# res = JSON.parse(res)

p res

# api_key:       6e6c4c1b71f816a5674596901a48616a
# shared_secret: 3e9b178cd216f46d
# auth_token:    1bde5e2d43e8bd11d605081d1347c64272823ffa
