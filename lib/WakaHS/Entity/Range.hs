{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module WakaHS.Entity.Range (Range (..)) where

import Data.Aeson (FromJSON, Value, withObject, (.:))
import Data.Aeson.Types (FromJSON (parseJSON), Parser)
import Data.Text (Text)
import GHC.Generics (Generic)

data Range where
  Range ::
    { end :: Text,
      endDate :: Text,
      endText :: Text,
      start :: Text,
      startDate :: Text,
      startText :: Text,
      timezone :: Text
    } ->
    Range
  deriving (Generic, Show, Eq)

instance FromJSON Range where
  parseJSON :: Value -> Parser Range
  parseJSON = withObject "Range" $ \o -> do
    end <- o .: "end"
    endDate <- o .: "end_date"
    endText <- o .: "end_text"
    start <- o .: "start"
    startDate <- o .: "start_date"
    startText <- o .: "start_text"
    timezone <- o .: "timezone"
    return Range {..}
