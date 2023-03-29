{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Render (renderFile, RenderComponent (..), Renderable (..)) where

import Data.Aeson (Key, object, (.=))
import Data.Aeson.Types (Pair)
import Data.Function ((&))
import qualified Data.Text.IO as TIO
import qualified Data.Text.Lazy as TL
import Text.Mustache (compileMustacheText, renderMustache)

class Renderable a where
  name :: a -> Key
  render :: a -> TL.Text

data RenderComponent where
  Wrap :: Renderable a => a -> RenderComponent

renderComponent :: RenderComponent -> Pair
renderComponent (Wrap comp) = name comp .= render comp

renderFile :: [RenderComponent] -> FilePath -> IO TL.Text
renderFile ctx file = do
  tmpl <- TIO.readFile file
  let eitherTemplate = compileMustacheText "dynamic template" tmpl
  case eitherTemplate of
    Left err -> error $ "Template compilation error: " ++ show err
    Right template -> do
      let context = ctx & map renderComponent & object
      let rendered = renderMustache template context
      return rendered
