# parse 日本標準産業分類

require 'open-uri'
require 'nokogiri'

url = 'http://www.soumu.go.jp/toukei_toukatsu/index/seido/sangyo/02toukatsu01_03000044.html'

html = open(url).read
doc = Nokogiri::HTML(html, url)

gyoshu = doc.xpath('//h3') # Nokogiri::XML::NodeSet

gyoshu.each do |node|
  str = node.children.text
  puts str[8, 100] # 100 is larger than the length of every words
end
