``` json
{
  "data": {
    "decimal": <string: total coding activity in decimal format>,
    "digital": <string: total coding activity in digital clock format>,
    "is_up_to_date": <boolean: true if the stats are up to date; when false, a 202 response code is returned and stats will be refreshed soon>,
    "percent_calculated": <integer: a number between 0 and 100 where 100 means the stats are up to date including Today’s time>,
    "range": {
      "end": <string: end of today as ISO 8601 UTC datetime>,
      "end_date": <string: today as Date string in YEAR-MONTH-DAY format>,
      "end_text": <string: today in human-readable format>,
      "start": <string: start of user created day as ISO 8601 UTC datetime>,
      "start_date": <string: day user was created in YEAR-MONTH-DAY format>,
      "start_text": <string: day user was created in human-readable format>,
      "timezone": <string: timezone used in Olson Country/Region format>
    }
    "text": <string: total time logged since account created as human readable string>,
    "timeout": <integer: keystroke timeout setting in minutes>,
    "total_seconds": <float: total number of seconds logged since account created>,
  }
}

```