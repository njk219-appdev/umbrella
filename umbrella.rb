p "Where are you?"

# input = gets.chomp
input = "chicago"
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{input}&key=#{ENV.fetch("GMAPS_KEY")}"

require "open-uri"
raw_response = URI.open(gmaps_url).read

require "json"
parse_response = JSON.parse(raw_response)

results_array = parse_response.fetch("results")
first_result = results_array.at(0)
geometry = first_result.fetch("geometry")
location = geometry.fetch("location")
lat = location.fetch("lat")
long = location.fetch("lng")
# gets lattitude and longitude
p lat
p long
# Starting weather API
weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{long}"

raw_response_weather = URI.open(weather_url).read
parse_response_weather = JSON.parse(raw_response_weather)

p parse_response_weather
