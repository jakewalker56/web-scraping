#http://www.stationindex.com/tv/by-state/
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def GetStateStations(state) 
  search_url = "http://www.stationindex.com/tv/by-state/" + state
  results = []
  npage = Nokogiri::HTML(open(search_url))
  stations = npage.css('font.marketsmall').select{|station| !station.css("b").empty?}
  stations.each do |station|
    new_station = {}
    new_station["name"] = station.css('a')[0].text
    new_station["url"] = station.css('a')[0]["href"]
    new_station["station"] = station.css('b')[0].text.strip
    
    index = 2
    id = station.css('b').select{|bold| bold.text.strip == "ID:"}
    if id && id[0]
      new_station["ID"] = station.text.split("\n")[index].split("ID:")[1]
      index+= 1
    else
      new_station["ID"] = ""
    end

    city = station.css('b').select{|bold| bold.text.strip == "City:"}
    if city && city[0]
      new_station["city"] = station.text.split("\n")[index].split("City:")[1]
      index += 1
    else
      new_station["city"] = ""
    end

    results << new_station
  end
  return results
end

states = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 
          'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 
          'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 
          'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']

tv_stations = File.open('tv_stations.csv', 'w')
tv_stations.write("Name, Station, City, State, ID, URL\n")
states.each do |state|
  stations = GetStateStations(state)
  stations.each do |station|
    station_info = station["name"] + ", " + station["station"] + ", " + station["city"] + ", " + station["ID"] + ", " + station["url"] + "\n"
    puts station_info
    tv_stations.write(station_info)
  end
end

