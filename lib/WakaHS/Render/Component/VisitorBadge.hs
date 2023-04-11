{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Component.VisitorBadge where

import Data.Aeson (Key)
import qualified Data.Text.Lazy as TL
import WakaHS.Render.Render (Renderable (name, render))

tmplf :: TL.Text -> TL.Text
tmplf id' = "![](https://shields.io/badge/dynamic/json?color=blue&label=Visitors&query=value&url=https://api.countapi.xyz/hit/" <> id' <> "." <> id' <> ")"

data VisitorBadge where
  VisitorBadge :: TL.Text -> VisitorBadge

instance Renderable VisitorBadge where
  name :: VisitorBadge -> Key
  name _ = "VisitorBadge"

  render :: VisitorBadge -> TL.Text
  render (VisitorBadge id') = tmplf id'
