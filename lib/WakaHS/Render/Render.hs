{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Render (renderFile, RenderContext (..)) where

import Data.Aeson (object, (.=))
import Data.Text (Text)
import qualified Data.Text.IO as TIO
import qualified Data.Text.Lazy as TL
import Text.Mustache (compileMustacheText, renderMustache)

data RenderContext where
  RenderContext :: {weeklySummary :: Maybe Text} -> RenderContext

renderFile :: RenderContext -> FilePath -> IO TL.Text
renderFile ctx file = do
  templateStr <- TIO.readFile file

  let eitherTemplate = compileMustacheText "dynamicTemplate" templateStr
  case eitherTemplate of
    Left err -> error $ "Template compilation error: " ++ show err
    Right template -> do
      let context = object ["WeeklySummary" .= weeklySummary ctx]
      let rendered = renderMustache template context
      return rendered
