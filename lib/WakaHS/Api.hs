{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}

module WakaHS.Api
  ( Api (..),
    ApiKey,
    Range (..),
  )
where

import Text.Printf (printf)

type ApiKey = String

data Api where
  AllTimeSinceToday :: Api
  Stats :: Range -> Api

instance Show Api where
  show :: Api -> String
  show AllTimeSinceToday = endpoint "/users/current/all_time_since_today"
  show (Stats r) = endpoint $ printf "/users/current/stats/%s" $ show r

data Range = Last7Days | Last30Days | Last6Months | LastYear | AllTime

instance Show Range where
  show :: Range -> String
  show Last7Days = "last_7_days"
  show Last30Days = "last_30_days"
  show Last6Months = "last_6_months"
  show LastYear = "last_year"
  show AllTime = "all_time"

endpoint :: String -> String
endpoint = (++) "https://wakatime.com/api/v1"
