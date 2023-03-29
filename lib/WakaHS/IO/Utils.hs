module WakaHS.IO.Utils where

import WakaHS.Api (Range (Last7Days))
import qualified WakaHS.Api as Api
import WakaHS.Entity.Stats (Stats)
import WakaHS.IO.Env (wakaApiKey)
import WakaHS.Request (request)
import WakaHS.Response (Response (Error, Ok))

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
