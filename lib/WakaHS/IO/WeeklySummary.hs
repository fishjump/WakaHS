module WakaHS.IO.WeeklySummary where

import WakaHS.Entity.Stats (Stats)
import WakaHS.IO.Utils (stats)

weeklySummary :: IO Stats
weeklySummary = do
  s <- stats
  case s of
    Left errs -> error $ show errs
    Right s' -> return s'
