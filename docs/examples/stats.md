``` json
{
  "data": {
    "total_seconds": <float: total coding activity, excluding "Other" language, as seconds for the given range of time>,
    "total_seconds_including_other_language": <float: total coding activity as seconds for the given range of time>,
    "human_readable_total": <string: total coding activity, excluding "Other" language, as human readable string>,
    "human_readable_total_including_other_language": <string: total coding activity as human readable string>,
    "daily_average": <float: average coding activity per day as seconds for the given range of time, excluding Other language>,
    "daily_average_including_other_language": <float: average coding activity per day as seconds for the given range of time>,
    "human_readable_daily_average": <string: daily average as human readable string, excluding Other language>,
    "human_readable_daily_average_including_other_language": <string: daily average as human readable string>,
    "categories": [
      {
        "name": <string: name of category, for ex: Coding or Debugging>,
        "total_seconds": <float: total coding activity as seconds>,
        "percent": <float: percent of time spent in this category>,
        "digital": <string: total coding activity for this category in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this category>,
        "minutes": <integer: minutes portion of coding activity for this category>
      }, …
    ],
    "projects": [
      {
        "name": <string: project name>,
        "total_seconds": <float: total coding activity as seconds>,
        "percent": <float: percent of time spent in this project>,
        "digital": <string: total coding activity for this project in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this project>,
        "minutes": <integer: minutes portion of coding activity for this project>
      }, …
    ],
    "languages": [
      {
        "name": <string: language name>,
        "total_seconds": <float: total coding activity spent in this language as seconds>,
        "percent": <float: percent of time spent in this language>,
        "digital": <string: total coding activity for this language in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this language>,
        "minutes": <integer: minutes portion of coding activity for this language>,
        "seconds": <integer: seconds portion of coding activity for this language>
      }, …
    ],
    "editors": [
      {
        "name": <string: editor name>,
        "total_seconds": <float: total coding activity spent in this editor as seconds>,
        "percent": <float: percent of time spent in this editor>,
        "digital": <string: total coding activity for this editor in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this editor>,
        "minutes": <integer: minutes portion of coding activity for this editor>,
        "seconds": <integer: seconds portion of coding activity for this editor>
      }, …
    ],
    "operating_systems": [
      {
        "name": <string: os name>,
        "total_seconds": <float: total coding activity spent in this os as seconds>,
        "percent": <float: percent of time spent in this os>,
        "digital": <string: total coding activity for this os in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this os>,
        "minutes": <integer: minutes portion of coding activity for this os>,
        "seconds": <integer: seconds portion of coding activity for this os>
      }, …
    ],
    "dependencies": [
      {
        "name": <string: dependency name>,
        "total_seconds": <float: total coding activity spent in this dependency as seconds>,
        "percent": <float: percent of time spent in this dependency>,
        "digital": <string: total coding activity for this dependency in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this dependency>,
        "minutes": <integer: minutes portion of coding activity for this dependency>,
        "seconds": <integer: seconds portion of coding activity for this dependency>
      }, …
    ],
    "machines": [
      {
        "name": <string: machine hostname and ip address>,
        "machine_name_id": <string: unique id of this machine>,
        "total_seconds": <float: total coding activity spent on this machine as seconds>,
        "percent": <float: percent of time spent on this machine>,
        "digital": <string: total coding activity for this machine in digital clock format>,
        "text": <string: total coding activity in human readable format>,
        "hours": <integer: hours portion of coding activity for this machine>,
        "minutes": <integer: minutes portion of coding activity for this machine>,
        "seconds": <integer: seconds portion of coding activity for this machine>
      }, …
    ],
    "best_day": {
      "date": <string: day with most coding time logged as Date string in YEAR-MONTH-DAY format>,
      "text": <string: total coding activity for this day in human readable format>,
      "total_seconds": <float: number of seconds of coding activity, including other language, for this day>
    },
    "range": <string: time range of these stats>,
    "human_readable_range": <string: time range as human readable string>,
    "holidays": <integer: number of days in this range with no coding time logged>,
    "days_including_holidays": <integer: number of days in this range>,
    "days_minus_holidays": <integer: number of days in this range excluding days with no coding time logged>,
    "status": <string: status of these stats in the cache>,
    "percent_calculated": <integer: percent these stats have finished updating in the background>,
    "is_already_updating": <boolean: true if these stats are being updated in the background>,
    "is_coding_activity_visible": <boolean: true if this user's coding activity is publicly visible>,
    "is_other_usage_visible": <boolean: true if this user's languages, editors, and operating system stats are publicly visible>,
    "is_stuck": <boolean: true if these stats got stuck while processing and will be recalculated in the background>,
    "is_including_today": <boolean: true if these stats include the current day; normally false except range "all_time">,
    "is_up_to_date": <boolean: true if these stats are up to date; when false, stats are missing or from an old time range and will be refreshed soon>,
    "start": <string: start of this time range as ISO 8601 UTC datetime>,
    "end": <string: end of this time range as ISO 8601 UTC datetime>,
    "timezone": <string: timezone used in Olson Country/Region format>,
    "timeout": <integer: value of the user's keystroke timeout setting in minutes>,
    "writes_only": <boolean: status of the user's writes_only setting>,
    "user_id": <string: unique id of this user>,
    "username": <string: public username for this user>,
    "created_at": <string: time when these stats were created in ISO 8601 format>,
    "modified_at": <string: time when these stats were last updated in ISO 8601 format>
  }
}

```