module Main where

import Control.Applicative (Applicative (liftA2))
import Data.Function ((&))
import qualified Data.Text.IO as TIO
import qualified Data.Text.Lazy as TL
import WakaHS.IO.Env (barStyle, input, output)
import WakaHS.IO.WeeklySummary (weeklySummary)
import WakaHS.Render.Component.WeeklySummary (WeeklySummary (WeeklySummary))
import WakaHS.Render.Render (RenderComponent (Wrap), renderFile)

renders :: IO [RenderComponent]
renders =
  sequence
    [ render $ liftA2 WeeklySummary barStyle weeklySummary
    ]
  where
    render = fmap Wrap

main :: IO ()
main = do
  o <- output
  i <- input
  rs <- renders

  rendered <- renderFile rs i
  TIO.writeFile o (rendered & TL.toStrict)
