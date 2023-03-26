{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module WakaHS.Render.WeeklySummary (renderWeeklySummary) where

import Data.Function ((&))
import Data.Text (Text, append)
import Text.Shakespeare.Text (st)
import WakaHS.Entity.Statistic (Editor, Language, OperatingSystem, Statistic (name, percent, text))
import WakaHS.Entity.Stats (Stats)
import qualified WakaHS.Entity.Stats as Stats
import WakaHS.Render.Utils (ProgressBarStyle (..), percentage, progressBar, renderList, spacesBetween)

renderWeeklySummary :: ProgressBarStyle -> Stats -> Text
renderWeeklySummary style stats =
  [st|

📊 **This Week I Spent My Time On** 

```text
🕑︎ Time Zone: #{timezone d}

💬 Programming Languages:
#{renderStatistics $ languages d & greaterThan1Percent}

🔥 Editors:
#{renderStatistics $ editors d & greaterThan1Percent}

💻 Operating System:
#{renderStatistics $ operatingSystems d & greaterThan1Percent}
```

|]
  where
    renderStatistics =
      renderList \s ->
        [st|#{renderName s}#{renderHours s}#{renderProgressBar s}#{renderPercentage s}|]
    renderName s = name s `append` spacesBetween 30 (name s)
    renderHours s = text s `append` spacesBetween 30 (text s)
    renderProgressBar s =
      let barText = progressBar20 $ percent s
       in barText `append` spacesBetween 30 barText
    progressBar20 = progressBar style 25
    renderPercentage = percentage . percent
    d = fromStats stats
    greaterThan1Percent = filter (\s -> percent s > 1)

data PageData = PageData
  { timezone :: Text,
    languages :: [Language],
    editors :: [Editor],
    operatingSystems :: [OperatingSystem]
  }

fromStats :: Stats -> PageData
fromStats s =
  PageData
    { timezone = Stats.timezone s,
      languages = Stats.languages s,
      editors = Stats.editors s,
      operatingSystems = Stats.operatingSystems s
    }