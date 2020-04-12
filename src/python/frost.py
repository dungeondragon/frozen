#!/usr/bin/env python3

import requests
import datetime

smhi_url = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/17.846746/lat/59.417838/data.json"

weather_data = requests.get(smhi_url).json()

for time_serie in weather_data['timeSeries']:

    for parameter in time_serie['parameters']:

        if parameter['name'] == 't'and parameter['values'][0] < 1:
            utc_time = datetime.datetime.strptime(time_serie['validTime'], "%Y-%m-%dT%H:%M:%SZ")
            utc_time = utc_time.replace(tzinfo=datetime.timezone.utc)
            local_time = utc_time.astimezone()
            print(str(local_time.strftime('%Y-%m-%d %H:00')) + ' ' + str(parameter['values'][0]))
