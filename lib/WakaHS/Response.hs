{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module WakaHS.Response (Response (..)) where

import Control.Applicative (Alternative (empty), (<|>))
import Data.Aeson
  ( FromJSON (parseJSON),
    Value,
    withObject,
    (.:),
  )
import Data.Aeson.Types (Parser)
import GHC.Generics (Generic)

data Response a where
  Ok :: a -> Response a
  Error :: {errors :: [String]} -> Response a
  deriving (Generic, Show, Eq)

instance FromJSON a => FromJSON (Response a) where
  parseJSON :: Value -> Parser (Response a)
  parseJSON =
    withObject "Response" $
      \o -> parseOk o <|> parseErrors o <|> parseError o <|> parseNothing o
    where
      parseOk o = do
        d <- o .: "data"
        return $ Ok d

      parseError o = do
        err <- o .: "error"
        return $ Error {errors = [err]}

      parseErrors o = do
        errors <- o .: "errors"
        return $ Error {..}

      parseNothing _ = empty
