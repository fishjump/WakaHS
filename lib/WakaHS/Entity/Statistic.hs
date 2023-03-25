{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module WakaHS.Entity.Statistic
  ( Category,
    Project,
    Statistic (..),
    Language,
    Editor,
    OperatingSystem,
    Dependency,
    Machine,
  )
where

import Data.Aeson (FromJSON, Value, withObject, (.:))
import Data.Aeson.Types (FromJSON (parseJSON), Parser)
import Data.Text (Text)
import GHC.Generics (Generic)

type Category = Statistic

type Project = Statistic

type Language = Statistic

type Editor = Statistic

type OperatingSystem = Statistic

type Dependency = Statistic

type Machine = Statistic

data Statistic where
  Statistic ::
    { name :: Text,
      totalSeconds :: Double,
      percent :: Double,
      digital :: Text,
      text :: Text,
      hours :: Int,
      minutes :: Int
      -- seconds :: Int  ??? They don't really have this field, their doc sucks
    } ->
    Statistic
  deriving (Generic, Show, Eq)

instance FromJSON Statistic where
  parseJSON :: Value -> Parser Statistic
  parseJSON = withObject "Statistic" $ \o -> do
    name <- o .: "name"
    totalSeconds <- o .: "total_seconds"
    percent <- o .: "percent"
    digital <- o .: "digital"
    text <- o .: "text"
    hours <- o .: "hours"
    minutes <- o .: "minutes"
    -- seconds <- o .: "seconds"
    return Statistic {..}
