require 'nokogiri'
require 'open-uri'
require 'csv'

html1 = URI.open('https://www.hospitalsafetygrade.org/all-hospitals')
parsed1 = Nokogiri::HTML.parse(html1)
id = 0
CSV.open("hospitals.csv", "a") do |csv|
  parsed1.at_css('.column1').css('a').each do |link|
    name = link.inner_text
    puts "#{id} + #{name}"
    csv << [id, name]
    id += 1
  end
end
html1.close