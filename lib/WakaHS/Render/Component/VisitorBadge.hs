{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Component.VisitorBadge where

import Data.Aeson (Key)
import qualified Data.Text.Lazy as TL
import WakaHS.Render.Render (Renderable (name, render))

tmplf :: TL.Text -> TL.Text
tmplf id' = "![visitors](https://visitor-badge.glitch.me/badge?page_id=" <> id' <> "." <> id' <> "&left_color=gray&right_color=red)"

data VisitorBadge where
  VisitorBadge :: TL.Text -> VisitorBadge

instance Renderable VisitorBadge where
  name :: VisitorBadge -> Key
  name _ = "VisitorBadge"

  render :: VisitorBadge -> TL.Text
  render (VisitorBadge id') = tmplf id'
