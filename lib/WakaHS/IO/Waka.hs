{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}

module WakaHS.IO.Waka where

import Data.Aeson (FromJSON)
import Data.Function ((&))
import Debug.Trace (trace)
import WakaHS.Api (Api, Range (Last7Days))
import qualified WakaHS.Api as Api
import WakaHS.Entity.AllTimeSinceToday (AllTimeSinceToday)
import WakaHS.Entity.Stats (Stats)
import WakaHS.IO.Env (wakaApiKey)
import WakaHS.Request (request)
import WakaHS.Response (Response (Error, Ok))

handleRspEither :: FromJSON a => Api -> IO (Either String a)
handleRspEither api = do
  key <- wakaApiKey
  res <- request api key
  case res of
    Left code -> return $ Left ("Response code: " ++ show code)
    Right body -> case body of
      Left err -> return $ Left ("Malform response body: " ++ err)
      Right rsp -> case rsp of
        Error errs -> return $ Left ("Errors from server :" ++ show errs)
        Ok s -> return $ Right s

fromEither :: Show a => IO (Either a b) -> IO b
fromEither e =
  e >>= \case
    Left errs -> error $ show errs
    Right rsp -> return rsp

eitherStats :: IO (Either String Stats)
eitherStats = handleRspEither $ Api.Stats Last7Days

stats :: IO Stats
stats = fromEither eitherStats

eitherAllTimeSinceToday :: IO (Either String AllTimeSinceToday)
eitherAllTimeSinceToday = handleRspEither Api.AllTimeSinceToday

allTimeSinceToday :: IO AllTimeSinceToday
allTimeSinceToday = fromEither eitherAllTimeSinceToday
