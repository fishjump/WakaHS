{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Function ((&))
import Data.Maybe (fromMaybe)
import qualified Data.Text.IO as TIO
import System.Environment (lookupEnv)
import WakaHS.Api (Range (Last7Days))
import qualified WakaHS.Api as Api
import WakaHS.Entity.Stats (Stats)
import qualified WakaHS.Render.Utils as ProgressBarStyle
import WakaHS.Render.WeeklySummary (renderWeeklySummary)
import WakaHS.Request (request)
import WakaHS.Response (Response (Error, Ok))

lookupEnvOrDefault :: String -> String -> IO String
lookupEnvOrDefault n d = lookupEnv n & fmap (fromMaybe d)

wakaApiKey :: IO String
wakaApiKey = lookupEnvOrDefault "WAKA_API_KEY" (error "expect env: WAKA_API_KEY")

stats :: IO (Either String Stats)
stats = do
  key <- wakaApiKey
  res <- request (Api.Stats Last7Days) key
  case res of
    Left code -> return $ Left ("Response code: " ++ show code)
    Right body -> case body of
      Left err -> return $ Left ("Malform response body: " ++ err)
      Right rsp -> case rsp of
        Error errs -> return $ Left ("Errors from server :" ++ show errs)
        Ok s -> return $ Right s

weeklySummary :: IO Stats
weeklySummary = do
  s <- stats
  case s of
    Left errs -> error $ show errs
    Right s' -> return s'

main :: IO ()
main = do
  summary <- weeklySummary

  let rendered = renderWeeklySummary ProgressBarStyle.Type1 summary
  TIO.writeFile "Weekly.md" rendered
