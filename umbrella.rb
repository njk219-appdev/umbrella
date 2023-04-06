p "Where are you?"
input = "seattle"
# input = gets.chomp
p "Checking the weather at #{input}. . . ."

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
p "Your coordinates are #{lat.to_s}, #{long.to_s}."

#-----------------------------------------------
# Starting weather API
weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{long}"

raw_response_weather = URI.open(weather_url).read
parse_response_weather = JSON.parse(raw_response_weather)
current_weather = parse_response_weather.fetch("currently")
current_temp = current_weather.fetch("temperature")
hourly_weather = parse_response_weather.fetch("hourly")
data = hourly_weather.fetch("data")
hour = data.at(0)
weather = hour.fetch("summary")
likelihood_of_rain = hour.fetch("precipProbability")
p "It is currently #{current_temp}F."
p "Next hour: #{weather}"
p likelihood_of_rain



if likelihood_of_rain > 0
  i = 0
  while i < 12
    hour = data.at(i)
    likelihood_of_rain = hour.fetch("precipProbability")
    percent_rain = likelihood_of_rain*100

    p "In #{(i+1).to_s} hours, there is a #{percent_rain.to_s} chance of precipitation."
    i = i + 1
  end
  p "You will likely need an umbrella!"
else
  p "You probably won't need an umbrella."
end
