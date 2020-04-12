#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'

smhi_url = 'https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/17.846746/lat/59.417838/data.json'

uri = URI(smhi_url)
response = Net::HTTP.get(uri)
weather_data = JSON.parse(response)

weather_data['timeSeries'].each { |time_serie|	
	
	time_serie['parameters'].each { |parameter|

		if parameter['name'] == 't' && parameter['values'][0] < 1
			utc_time = DateTime.strptime(time_serie['validTime'], "%Y-%m-%dT%H:%M:%SZ")
			local_time = utc_time.new_offset(DateTime.now.offset)
            puts "#{local_time.strftime('%Y-%m-%d %H:00')} #{parameter['values'][0]}"
		end	
	}
}
