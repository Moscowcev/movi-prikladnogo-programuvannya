require 'nokogiri'
require 'open-uri'
require 'csv'

html = URI.open('https://www.hospitalsafetygrade.org/all-hospitals')
parsed = Nokogiri::HTML.parse(html1)
id = 0
CSV.open("hospitals.csv", "a") do |csv|
  parsed.at_css('.column1').css('a').each do |link|
    name = link.inner_text
    csv << [id, name]
    id += 1
  end
end
html.close