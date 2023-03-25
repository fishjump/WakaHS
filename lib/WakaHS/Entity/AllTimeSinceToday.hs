{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module WakaHS.Entity.AllTimeSinceToday (AllTimeSinceToday (..)) where

import Data.Aeson (FromJSON (parseJSON), Value, withObject, (.:))
import Data.Aeson.Types (Parser)
import GHC.Generics (Generic)
import WakaHS.Entity.Range (Range)

data AllTimeSinceToday where
  AllTimeSinceToday ::
    { decimal :: String,
      digital :: String,
      isUpToDate :: Bool,
      percentCalculated :: Integer,
      timeRange :: Range,
      rangeInText :: String,
      timeout :: Integer,
      totalSeconds :: Double
    } ->
    AllTimeSinceToday
  deriving (Generic, Show, Eq)

instance FromJSON AllTimeSinceToday where
  parseJSON :: Value -> Parser AllTimeSinceToday
  parseJSON = withObject "AllTimeSinceToday" $ \o -> do
    decimal <- o .: "decimal"
    digital <- o .: "digital"
    isUpToDate <- o .: "is_up_to_date"
    percentCalculated <- o .: "percent_calculated"
    timeRange <- o .: "range"
    rangeInText <- o .: "text"
    timeout <- o .: "timeout"
    totalSeconds <- o .: "total_seconds"
    return AllTimeSinceToday {..}
