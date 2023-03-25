{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module WakaHS.Entity.Stats (Stats (..)) where

import Data.Aeson (FromJSON (parseJSON), Value, withObject, (.:))
import Data.Aeson.Types (Parser)
import GHC.Generics (Generic)
import WakaHS.Entity.BestDay (BestDay)
import WakaHS.Entity.Statistic
  ( Category,
    Dependency,
    Editor,
    Language,
    Machine,
    OperatingSystem,
    Project,
  )

data Stats where
  Stats ::
    { totalSeconds :: Double,
      totalSecondsIncludingOtherLanguage :: Double,
      humanReadableTotal :: String,
      humanReadableTotalIncludingOtherLanguage :: String,
      dailyAverage :: Double,
      dailyAverageIncludingOtherLanguage :: Double,
      humanReadableDailyAverage :: String,
      humanReadableDailyAverageIncludingOtherLanguage :: String,
      categories :: [Category],
      projects :: [Project],
      languages :: [Language],
      editors :: [Editor],
      operating_systems :: [OperatingSystem],
      dependencies :: [Dependency],
      machines :: [Machine],
      best_day :: BestDay,
      range :: String,
      humanReadableRange :: String,
      holidays :: Int,
      daysIncludingHolidays :: Int,
      daysMinusHolidays :: Int,
      status :: String,
      percentCalculated :: Int,
      isAlreadyUpdating :: Bool,
      isCodingActivityVisible :: Bool,
      isOtherUsageVisible :: Bool,
      isStuck :: Bool,
      isIncludingToday :: Bool,
      isUpToDate :: Bool,
      start :: String,
      end :: String,
      timezone :: String,
      timeout :: Int,
      writesOnly :: Bool,
      userId :: String,
      username :: String,
      createdAt :: String,
      modifiedAt :: String
    } ->
    Stats
  deriving (Generic, Show, Eq)

instance FromJSON Stats where
  parseJSON :: Value -> Parser Stats
  parseJSON = withObject "Stats" $ \o -> do
    totalSeconds <- o .: "total_seconds"
    totalSecondsIncludingOtherLanguage <- o .: "total_seconds_including_other_language"
    humanReadableTotal <- o .: "human_readable_total"
    humanReadableTotalIncludingOtherLanguage <- o .: "human_readable_total_including_other_language"
    dailyAverage <- o .: "daily_average"
    dailyAverageIncludingOtherLanguage <- o .: "daily_average_including_other_language"
    humanReadableDailyAverage <- o .: "human_readable_daily_average"
    humanReadableDailyAverageIncludingOtherLanguage <- o .: "human_readable_daily_average_including_other_language"
    categories <- o .: "categories"
    projects <- o .: "projects"
    languages <- o .: "languages"
    editors <- o .: "editors"
    operating_systems <- o .: "operating_systems"
    dependencies <- o .: "dependencies"
    machines <- o .: "machines"
    best_day <- o .: "best_day"
    range <- o .: "range"
    humanReadableRange <- o .: "human_readable_range"
    holidays <- o .: "holidays"
    daysIncludingHolidays <- o .: "days_including_holidays"
    daysMinusHolidays <- o .: "days_minus_holidays"
    status <- o .: "status"
    percentCalculated <- o .: "percent_calculated"
    isAlreadyUpdating <- o .: "is_already_updating"
    isCodingActivityVisible <- o .: "is_coding_activity_visible"
    isOtherUsageVisible <- o .: "is_other_usage_visible"
    isStuck <- o .: "is_stuck"
    isIncludingToday <- o .: "is_including_today"
    isUpToDate <- o .: "is_up_to_date"
    start <- o .: "start"
    end <- o .: "end"
    timezone <- o .: "timezone"
    timeout <- o .: "timeout"
    writesOnly <- o .: "writes_only"
    userId <- o .: "user_id"
    username <- o .: "username"
    createdAt <- o .: "created_at"
    modifiedAt <- o .: "modified_at"

    return Stats {..}
