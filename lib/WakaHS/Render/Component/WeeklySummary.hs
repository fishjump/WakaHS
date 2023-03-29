{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module WakaHS.Render.Component.WeeklySummary (WeeklySummary (..)) where

import Data.Aeson (Key, object, (.=))
import Data.Function ((&))
import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import Text.Mustache (compileMustacheText)
import Text.Mustache.Render (renderMustache)
import Text.Mustache.Type (Template)
import Text.Printf (printf)
import Text.RawString.QQ (r)
import qualified WakaHS.Entity.Statistic as Statistic
import WakaHS.Entity.Stats (Stats (editors, languages, operatingSystems, timezone))
import WakaHS.Render.Render (Renderable (name, render))
import WakaHS.Render.Utils (ProgressBarStyle (..), percentage, progressBar, spacesBetween)

data WeeklySummary where
  WeeklySummary :: ProgressBarStyle -> Stats -> WeeklySummary

instance Renderable WeeklySummary where
  name :: WeeklySummary -> Key
  name _ = "WeeklySummary"

  render :: WeeklySummary -> TL.Text
  render (WeeklySummary barStyle stats) = renderMustache template ctx
    where
      ctx = object ["timezone" .= tz, "languages" .= ls, "editors" .= es, "operatingSystems" .= os]
      tz = timezone stats
      ls = languages stats & greaterThan1Percent & fmap renderStatistics
      es = editors stats & greaterThan1Percent & fmap renderStatistics
      os = operatingSystems stats & greaterThan1Percent & fmap renderStatistics
      greaterThan1Percent = filter (\statistics -> Statistic.percent statistics > 1)
      renderStatistics s = printf "%s%s%s%s" name' hours' bar' percent' & TL.pack
        where
          name' = Statistic.name s `T.append` spacesBetween 30 (Statistic.name s)
          hours' = Statistic.text s `T.append` spacesBetween 30 (Statistic.text s)
          bar' =
            let barText = progressBar barStyle 25 $ Statistic.percent s
             in barText `T.append` spacesBetween 30 barText
          percent' = (percentage . Statistic.percent) s

template :: Template
template = case t of
  Left _ -> error "Syntax error: WeeklySummary"
  Right t' -> t'
  where
    t = compileMustacheText "WeeklySummary" tmplStr

tmplStr :: T.Text
tmplStr =
  [r|
📊 **This Week I Spent My Time On** 

```text
🕑︎ Time Zone: {{timezone}}

💬 Programming Languages:
{{#languages}}
- {{.}}
{{/languages}}

🔥 Editors:
{{#editors}}
- {{.}}
{{/editors}}

💻 Operating System:
{{#operatingSystems}}
- {{.}}
{{/operatingSystems}}
```
|]
