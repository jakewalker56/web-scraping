#http://www.oddsportal.com/basketball/usa/nba-2013-2014/results/#/page/1/
require 'rubygems'
require 'nokogiri'
require 'open-uri'


#http://fb.oddsportal.com/ajax-sport-country-tournament-archive/3/rcgzdfbO/X0/1/0/2/
#http://fb.oddsportal.com/ajax-sport-country-tournament-archive/3/MmbLsWh8/X0/1/0/4/

#map the category names to the ajax call ID's used.  These were found manually using the chrome network inspector,
#and may change any time?
category_map = {
  "nba-2015-2016" => "MmbLsWh8", 
  "nba-2014-2015" => "rcgzdfbO"
  } 
  # "nba-2013-2014", "nba-2012-2013", "nba-2011-2012", 
  # "nba-2010-2011", "nba-2009-2010", "nba-2008-2009", 
  # "nba-2007-2008", "nba-2006-2007", "nba-2005-2006", 
  # "nba-2004-2005", "nba-2003-2004", "nba-2002-2003",
  # "nba-2001-2002", "nba-2000-2001", "nba-1999-2000"

base_url = "http://fb.oddsportal.com/ajax-sport-country-tournament-archive/3/"
url_suffix = "/X0/1/0/"


outfile = File.open('oddsportal.csv', 'w')
#write header row 
index.write("Category,Inerpolated Date,Time,Home Team,Away Team,Column 1,Column 2,Column B's")

category_map.keys.each do |key|
  category = category_map[key]
  page_index = 1
  while true
    search_url = base_url + category + url_suffix + page_index.to_s + "/"
    while true
      begin 
        npage = Nokogiri::HTML(open(search_url))
        break
      rescue
        puts "caught exception..."
      end
    end
  end
  #if return code is bad, we've reached the end of our page index.  Next category!
  if 
  #find table
  result_table = npage.css('table').select{|result| result["id"] == "tournamentTable"}[0]
  
  #for each line in our table...

  #if header line, (date/situation), set locals


  sleep(0.2)
  puts "finished parsing " + line
end
index.close



# So it turns out the actual data is loaded via ajax.  We're now calling the javascript callback directly, and
# pulling our data out of the response

# category_names = ["nba-2015-2016", "nba-2014-2015", "nba-2013-2014", "nba-2012-2013", "nba-2011-2012", 
#   "nba-2010-2011", "nba-2013-2014", "nba-2013-2014", "nba-2013-2014", "nba-2013-2014", "nba-2013-2014", "nba-2013-2014", ]
# base_url = "http://www.oddsportal.com/basketball/usa/"
# url_suffix = "/results/#/page/"


# outfile = File.open('oddsportal.csv', 'w')
# #write header row 
# index.write("Category,Inerpolated Date,Time,Home Team,Away Team,Column 1,Column 2,Column B's")

# category_names.each do |category|
#   page_index = 1
#   while true
#     search_url = base_url + category + url_suffix + page_index.to_s + "/"
#     while true
#       begin 
#         npage = Nokogiri::HTML(open(search_url))
#         break
#       rescue
#         puts "caught exception..."
#       end
#     end
#   end
#   #if return code is bad, we've reached the end of our page index.  Next category!
#   if 
#   #find table
#   result_table = npage.css('table').select{|result| result["id"] == "tournamentTable"}[0]
  
#   #for each line in our table...

#   #if header line, (date/situation), set locals


#   sleep(0.2)
#   puts "finished parsing " + line
# end
# index.close
