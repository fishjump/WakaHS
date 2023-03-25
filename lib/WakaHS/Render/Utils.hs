{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Utils (spacesBetween, br, renderList, progressBar, ProgressBarStyle (..), percentage) where

import Data.Function ((&))
import Data.Text (Text, append, length, pack, replicate)
import Text.Printf (printf)
import Prelude hiding (length, replicate)

spacesBetween :: Int -> Text -> Text
spacesBetween n s = replicate spacesNeeded " "
  where
    spacesNeeded = n - length s

br :: Text -> Text
br = append "\n"

renderList :: Foldable t => (a -> Text) -> t a -> Text
renderList f = foldr (append . br . f) ""

data ProgressBarStyle = Type1 | Type2 | Type3

progressWidth :: Int -> Double -> Int
progressWidth width progress = round (progress / 100.0 * fromIntegral width)

progressBar :: ProgressBarStyle -> Int -> Double -> Text
progressBar Type1 width progress = append (replicate (progressWidth width progress) "█") (replicate (width - progressWidth width progress) "░")
progressBar Type2 width progress = append (replicate (progressWidth width progress) "⣿") (replicate (width - progressWidth width progress) "⣀")
progressBar Type3 width progress = append (replicate (progressWidth width progress) "⬛") (replicate (width - progressWidth width progress) "⬜")

percentage :: Double -> Text
percentage v = printf "%.2f%%" v & pack
