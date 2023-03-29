module WakaHS.IO.Env (wakaApiKey, ghToken, input, output, barStyle) where

import Data.Function ((&))
import Data.Maybe (fromMaybe)
import System.Environment (lookupEnv)
import WakaHS.Render.Utils (ProgressBarStyle)
import qualified WakaHS.Render.Utils as ProgressBarStyle

lookupEnvOrDefault :: String -> String -> IO String
lookupEnvOrDefault n d = lookupEnv n & fmap (fromMaybe d)

wakaApiKey :: IO String
wakaApiKey = lookupEnvOrDefault "INPUT_WAKA_API_KEY" (error "expect env: INPUT_WAKA_API_KEY")

ghToken :: IO String
ghToken = lookupEnvOrDefault "INPUT_GH_TOKEN" (error "expect env: INPUT_GH_TOKEN")

input :: IO String
input = lookupEnvOrDefault "INPUT_TEMPLATE" "/github/workspace/template.md"

output :: IO String
output = lookupEnvOrDefault "INPUT_README" "/github/workspace/README.md"

barStyle :: IO ProgressBarStyle
barStyle = do
  t <- lookupEnvOrDefault "INPUT_BAR_STYLE" "Type1"
  return $ case t of
    "Type1" -> ProgressBarStyle.Type1
    "Type2" -> ProgressBarStyle.Type2
    "Type3" -> ProgressBarStyle.Type3
    _ -> error "malform INPUT_BAR_STYLE, expect one of: Type1, Type2, Type3"
