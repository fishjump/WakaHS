module Main where

import ApiTest (apiTests)
import ResponseTest (responseTests)
import Test.Tasty (TestTree, defaultMain, testGroup)

tests :: TestTree
tests = testGroup "Tests" [apiTests, responseTests]

main :: IO ()
main = defaultMain tests
