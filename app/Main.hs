{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Function ((&))
import Data.Maybe (fromMaybe)
import qualified Data.Text.IO as TIO
import Data.Text.Lazy (toStrict)
import qualified Data.Text.Lazy as TL
import System.Environment (lookupEnv)
import WakaHS.Api (Range (Last7Days))
import qualified WakaHS.Api as Api
import WakaHS.Entity.Stats (Stats)
import WakaHS.Render.Component.WeeklySummary (WeeklySummary (..))
import WakaHS.Render.Render (RenderComponent (Wrap), Renderable, renderFile)
import qualified WakaHS.Render.Utils as ProgressBarStyle
import WakaHS.Request (request)
import WakaHS.Response (Response (Error, Ok))

lookupEnvOrDefault :: String -> String -> IO String
lookupEnvOrDefault n d = lookupEnv n & fmap (fromMaybe d)

wakaApiKey :: IO String
wakaApiKey = lookupEnvOrDefault "WAKA_API_KEY" (error "expect env: WAKA_API_KEY")

output :: IO String
output = lookupEnvOrDefault "OUTPUT" "README.md"

input :: IO String
input = lookupEnvOrDefault "INPUT" "template.md"

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

render :: Renderable b => (a -> b) -> IO a -> IO RenderComponent
render f = fmap (Wrap . f)

renders :: IO [RenderComponent]
renders =
  sequence
    [ render (WeeklySummary ProgressBarStyle.Type1) weeklySummary
    ]

main :: IO ()
main = do
  o <- output
  i <- input
  rs <- renders

  rendered <- renderFile rs i
  putStrLn $ TL.unpack rendered
  TIO.writeFile o (rendered & toStrict)
