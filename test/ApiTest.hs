module ApiTest (apiTests) where

import Test.Tasty (TestTree, testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)
import WakaHS.Api
  ( Api (AllTimeSinceToday, Stats),
    Range (Last7Days),
  )

allTimeSinceToday :: TestTree
allTimeSinceToday = testCase "all time since today" $ assertEqual "" "https://wakatime.com/api/v1/users/current/all_time_since_today" (show AllTimeSinceToday)

last7Days :: TestTree
last7Days = testCase "last 7 days" $ assertEqual "" "https://wakatime.com/api/v1/users/current/stats/last_7_days" (show $ Stats Last7Days)

apiTests :: TestTree
apiTests = testGroup "Endpoint Tests" [allTimeSinceToday, last7Days]
