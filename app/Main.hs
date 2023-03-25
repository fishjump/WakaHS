module Main where

import Control.Monad (when)
import Data.Either (fromLeft, fromRight, isLeft, isRight)
import Data.Function ((&))
import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)
import qualified WakaHS.Api as Api
import WakaHS.Entity.AllTimeSinceToday (AllTimeSinceToday)
import WakaHS.Request (request)
import WakaHS.Response (Response)

lookupEnvOrDefault :: String -> String -> IO String
lookupEnvOrDefault n d = lookupEnv n & fmap (fromMaybe d)

wakaApiKey :: IO String
wakaApiKey = lookupEnvOrDefault "WAKA_API_KEY" (error "expect env: WAKA_API_KEY")

main :: IO ()
main = do
  key <- wakaApiKey
  res <- request Api.AllTimeSinceToday key
  when (isLeft res) $ putStrLn $ "Response code: " ++ show (fromLeft undefined res)

  let d = fromRight undefined res
  when (isLeft d) $ putStrLn $ "Malform response body: " ++ fromLeft undefined d
  when (isRight d) $ putStrLn $ "Response body: " ++ show (fromRight undefined d :: Response AllTimeSinceToday)
