{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module WakaHS.Entity.BestDay (BestDay (..)) where

import Data.Aeson (FromJSON, Value, withObject, (.:))
import Data.Aeson.Types (FromJSON (parseJSON), Parser)
import Data.Text (Text)
import GHC.Generics (Generic)

data BestDay where
  BestDay ::
    {date :: Text, text :: Text, totalSeconds :: Double} ->
    BestDay
  deriving (Generic, Show, Eq)

instance FromJSON BestDay where
  parseJSON :: Value -> Parser BestDay
  parseJSON = withObject "BestDay" $ \o -> do
    date <- o .: "date"
    text <- o .: "text"
    totalSeconds <- o .: "total_seconds"
    return BestDay {..}
