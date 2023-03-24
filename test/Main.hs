module Main where

import Test.HUnit (Counts, Test, Testable (test), runTestTT, (~:), (~=?))

tests :: Test
tests = test ["test1" ~: "1+1=2" ~: (1 + 1) ~=? 2]

main :: IO Counts
main = runTestTT tests
