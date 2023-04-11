{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module ResponseTest (responseTests) where

import Data.Aeson (decode)
import Data.ByteString.Lazy (ByteString)
import Data.ByteString.Lazy.Char8 (pack)
import Data.Function ((&))
import Data.String.QQ (s)
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)
import WakaHS.Entity.AllTimeSinceToday (AllTimeSinceToday (..))
import WakaHS.Entity.Range (Range (..))
import WakaHS.Response (Response (Error, Ok))

meetMalform :: TestTree
meetMalform = testCase "malform data" $ assertEqual "" Nothing (decode "{\"call\": \"Ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn.\"}" :: Maybe (Response AllTimeSinceToday))

meetError :: TestTree
meetError =
  testCase "meet an error" $ assertEqual "" (Just $ Error ["This is an error"]) (decode "{\"error\": \"This is an error\"}" :: Maybe (Response AllTimeSinceToday))

meetErrors :: TestTree
meetErrors = testCase "meet an error array" $ assertEqual "" (Just $ Error ["from an error array"]) (decode "{\"errors\": [\"from an error array\"]}" :: Maybe (Response AllTimeSinceToday))

allTimeSinceTodayJSON :: ByteString
allTimeSinceTodayJSON = [s|{"data":{"decimal":"122.48","digital":"122:29","is_up_to_date":true,"percent_calculated":100,"range":{"end":"2023-03-26T03:59:59Z","end_date":"2023-03-25","end_text":"Today","start":"2023-02-10T05:00:00Z","start_date":"2023-02-10","start_text":"Fri Feb 10th 2023","timezone":"America/New_York"},"text":"124 hrs 34 mins","timeout":15,"total_seconds":448439.99224}}|] & pack

allTimeSinceTodayData :: AllTimeSinceToday
allTimeSinceTodayData =
  AllTimeSinceToday
    { decimal = "122.48",
      digital = "122:29",
      isUpToDate = True,
      percentCalculated = Just 100,
      timeRange = Range {end = "2023-03-26T03:59:59Z", endDate = "2023-03-25", endText = "Today", start = "2023-02-10T05:00:00Z", startDate = "2023-02-10", startText = "Fri Feb 10th 2023", timezone = "America/New_York"},
      rangeInText = "124 hrs 34 mins",
      timeout = 15,
      totalSeconds = 448439.99224
    }

allTimeSinceToday :: TestTree
allTimeSinceToday = testCase "parse all-time-since-today" $ assertEqual "" (Just $ Ok allTimeSinceTodayData) (decode allTimeSinceTodayJSON :: Maybe (Response AllTimeSinceToday))

responseTests :: TestTree
responseTests = testGroup "Response Tests" [meetMalform, meetError, meetErrors, allTimeSinceToday]
