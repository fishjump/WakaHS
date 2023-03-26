module WakaHS.Request (request) where

import Data.Aeson (FromJSON, eitherDecode)
import Data.ByteString.Lazy.Char8 (pack)
import Data.Function ((&))
import Network.Curl (CurlCode (CurlOK), curlGetString)
import WakaHS.Api (Api, ApiKey)
import WakaHS.Response (Response)

request :: (FromJSON a) => Api -> ApiKey -> IO (Either CurlCode (Either String (Response a)))
request e k = curlGetString url opts & fmap toEither
  where
    url = base ++ params
    base = show e
    params = "?api_key=" ++ k
    opts = []

toEither :: FromJSON a => (CurlCode, [Char]) -> Either CurlCode (Either String (Response a))
toEither (code, str)
  | code == CurlOK = Right (str & pack & eitherDecode)
  | otherwise = Left code
