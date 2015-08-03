require 'rubygems'
require 'yahoo_weatherman'


puts "What is your zipcode?"

zipcode = gets

def getforecasts (zipcode)
    today = Time.now.strftime('%w').to_i
    client = Weatherman::Client.new
    weather = client.lookup_by_location(zipcode)
    weather.forecasts.each do |fore|
        day = fore['date'] 
        week_day = day.strftime('%w').to_i         
        if week_day == today
           day_name = 'Today'
        elsif week_day == today + 1
           day_name = 'Tomorrow'
        else
           day_name = day.strftime('%A')
        end
        cond = fore['text'].to_s.downcase
        low = fore['low']
        high = fore['high']
        puts day_name + " is going to be " + cond + " with a low of " + tempInFahrenheit(low) + " and a high of " + tempInFahrenheit(high) + " degrees Celcius."
        
    end
    return
end

def getweather (zipcode)
    client = Weatherman::Client.new
    weather = client.lookup_by_location(zipcode)
    arr = Array.new()
    weather.description.each_line do |line|
        arr.push(line)
    end
    return arr.at(3).split(',')[0].downcase
end

def getlocation (zipcode)
    client = Weatherman::Client.new
    response = client.lookup_by_location(zipcode)

    return response.location['city']

end

def tempInFahrenheit(celcius)
    return (celcius.to_i*1.8 + 32.00).round(1).to_s
end

puts "Weather in " + getlocation(zipcode) + " is " + getweather(zipcode) + "."

puts "Forecasts for the next 5 days."
puts getforecasts(zipcode)

