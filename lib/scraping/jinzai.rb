# 人材ドラフト
#
# 事務所名、所在地、電話、メール、従業員数、業種、募集職種

require 'open-uri'
require 'nokogiri'
require 'pry'

base_url = 'https://www.jinzai-draft.com/jobsearch/php/search.php'
paginate_param = 'page=1&li_cnt_js=100&'

urls = {
  '新着求人で探す(左メニュー)':  'submit_srch=jouken_s&new_s=1',
}

def request(url)
  html = open(url).read

  Nokogiri::HTML(html, url)
end

File.open('jinzai-draft.csv', 'w') do |f|
  urls.each do |title, param|
    puts ''
    puts title
    puts ''

    target = base_url + '?' + paginate_param + param

    puts 'Request 投げまっせ -> ' + target

    # request 投げる
    doc = request target

    companies = doc.css('div#contents div#resultArea div.seachResultBox01')

    puts '結果が 100 こえてる可能性あるで' if companies.length > 100

    companies.each do |company|
      # company -> 一つの企業部分
      name = company.css('h2').first.children.first.children.to_s
      link_parts = company.css('h2').first.children.first.values
      next if link_parts.empty?
      link = link_parts.first[2..-1]

      company_url = 'https://www.jinzai-draft.com/jobsearch' + link

      # request 投げる
      sleep 5
      # company_doc -> 個別の企業ページ
      company_doc = request company_url

      table = company_doc.css('div#contents div.closeUpContents01 div.compprof div.profArea01 table tr')

      location         = table.find { |r| r.css('th').children.to_s == '所在地' }&.css('td')&.children&.to_s&.strip
      tel              = table.find { |r| r.css('th').children.to_s == '電話番号' }&.css('td')&.children&.to_s&.strip
      mail             = table.find { |r| r.css('th').children.to_s == 'E-Mail' }&.css('td a')&.children&.to_s&.strip
      num_of_employees = table.find { |r| r.css('th').children.to_s == '従業員数' }&.css('td')&.children&.to_s&.strip
      biz_type         = table.find { |r| r.css('th').children.to_s == '業種' }&.css('td')&.children&.to_s&.strip

      recruits = company_doc.css('div#contents div.closeUpContents01 ul.jobCategoryList01 li a')&.children
      recruits.each do |recruit|
        recruit_job = recruit&.to_s&.strip

        puts [name, location, tel, mail, num_of_employees, biz_type, recruit_job].join(',')
        f.puts [name, location, tel, mail, num_of_employees, biz_type, recruit_job].join(',')
      end
    end
  end
end
