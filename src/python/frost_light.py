#!/usr/bin/env python3

import requests
import datetime
import json

smhi_url = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/17.846746/lat/59.417838/data.json"

weather_data = requests.get(smhi_url).json()

for time_serie in weather_data['timeSeries']:

    for parameter in time_serie['parameters']:

        if parameter['name'] == 't'and parameter['values'][0] < 1:
            light_url = 'http://192.168.0.4/api/mJr457Xlpga0VczbWf4ZPJY4HaWTK4o3dUaXWeW5/lights/8/state/'
            requests.put(light_url, data = json.dumps({"on": True, "hue": 46644, "sat": 255}))        
            break 
