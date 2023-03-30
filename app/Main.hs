module Main where

import Control.Applicative (Applicative (liftA2))
import Data.Function ((&))
import qualified Data.Text.IO as TIO
import qualified Data.Text.Lazy as TL
import WakaHS.IO.Env (barStyle, input, output)
import WakaHS.IO.Github (currentUserLogin)
import WakaHS.IO.Waka (allTimeSinceToday, stats)
import WakaHS.Render.Component.CodeTimeBadge (CodeTimeBadge (CodeTimeBadge))
import WakaHS.Render.Component.VisitorBadge (VisitorBadge (VisitorBadge))
import WakaHS.Render.Component.WeeklySummary (WeeklySummary (WeeklySummary))
import WakaHS.Render.Render (RenderComponent (Wrap), Renderable, renderFile)

renders :: IO [RenderComponent]
renders =
  sequence
    [ render $ liftA2 WeeklySummary barStyle stats,
      render $ fmap VisitorBadge currentUserLogin,
      render $ fmap CodeTimeBadge allTimeSinceToday
    ]
  where
    render :: Renderable a => IO a -> IO RenderComponent
    render = fmap Wrap

main :: IO ()
main = do
  o <- output
  i <- input
  rs <- renders

  rendered <- renderFile rs i
  TIO.writeFile o (rendered & TL.toStrict)
