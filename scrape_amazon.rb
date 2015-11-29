#"http://www.amazon.com/s/ref=nb_sb_ss_c_0_20?url=search-alias%3Dstripbooks&field-keywords=money+by+martin+amis&sprefix=Money+by+Martin+Amis%2Caps%2C190"
require 'rubygems'
require 'nokogiri'
require 'open-uri'

text = File.open('books.txt').read
index = File.open('index.html', 'w')
index.write("<table>")
text.each_line do |line|
  search_url = "http://www.amazon.com/s?url=search-alias%3Dstripbooks&field-keywords=" + URI::encode(line)
  while true
	  begin 
	  	npage = Nokogiri::HTML(open(search_url))
	  	break
	  rescue
	  	puts "caught exception..."
	  end
  end
  first_result = npage.css('img').select{|result| result["alt"] == "Product Details"}[0]
  first_result_image = first_result["src"]
  index.write("<tr><td><img src='" + first_result_image  + "'></td><td>" + line + "</td></tr>")
  sleep(0.2)
  puts "finished parsing " + line
end
index.write("</table>")
index.close
