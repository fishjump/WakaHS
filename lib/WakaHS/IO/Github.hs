{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module WakaHS.IO.Github where

import qualified Data.ByteString.Char8 as BS
import Data.Text.Lazy (fromStrict)
import qualified Data.Text.Lazy as TL
import GitHub (Auth (OAuth), User (userLogin), github, untagName)
import qualified GitHub
import WakaHS.IO.Env (ghToken)

auth :: IO Auth
auth = fmap (OAuth . BS.pack) ghToken

eitherCurrentUser :: IO (Either GitHub.Error GitHub.User)
eitherCurrentUser = auth >>= \auth' -> github auth' GitHub.userInfoCurrentR

currentUser :: IO GitHub.User
currentUser =
  eitherCurrentUser >>= \case
    Left err -> error $ "failed to get current user, reason: " ++ show err
    Right user -> return user

-- l = GitHub.User.login

currentUserLogin :: IO TL.Text
currentUserLogin = fmap (fromStrict . untagName . userLogin) currentUser
