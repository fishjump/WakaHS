{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Component.VisitorBadge where

import Data.Aeson (Key)
import qualified Data.Text.Lazy as TL
import WakaHS.Render.Render (Renderable (name, render))

tmplf :: TL.Text -> TL.Text
tmplf id' = "![](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2F" <> id' <> "%2F" <> id' <> "&countColor=%232ccce4&style=flat)"

data VisitorBadge where
  VisitorBadge :: TL.Text -> VisitorBadge

instance Renderable VisitorBadge where
  name :: VisitorBadge -> Key
  name _ = "VisitorBadge"

  render :: VisitorBadge -> TL.Text
  render (VisitorBadge id') = tmplf id'
