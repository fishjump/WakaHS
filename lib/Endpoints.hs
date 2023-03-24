{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}

module Endpoints where

import Text.Printf (printf)

data Endpoints where
  AllTimeSinceToday :: Endpoints
  Stats :: Range -> Endpoints

instance Show Endpoints where
  show :: Endpoints -> String
  show AllTimeSinceToday = endpoint "/users/current/all_time_since_today"
  show (Stats r) = endpoint $ printf "/api/v1/users/current/stats/%s" $ show r

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
