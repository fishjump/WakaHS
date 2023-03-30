{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.Render.Component.CodeTimeBadge where

import Data.Aeson (Key)
import Data.Text.Lazy (replace)
import qualified Data.Text.Lazy as TL
import WakaHS.Entity.AllTimeSinceToday (AllTimeSinceToday (rangeInText))
import WakaHS.Render.Render (Renderable (name, render))

tmplf :: TL.Text -> TL.Text
tmplf time = "![Code Time](https://img.shields.io/badge/Code%20Time-" <> time' <> "-blue)"
  where
    time' = replace " " "%20" time

data CodeTimeBadge where
  CodeTimeBadge :: AllTimeSinceToday -> CodeTimeBadge

instance Renderable CodeTimeBadge where
  name :: CodeTimeBadge -> Key
  name _ = "CodeTimeBadge"

  render :: CodeTimeBadge -> TL.Text
  render (CodeTimeBadge data') = tmplf (TL.fromStrict $ rangeInText data')
