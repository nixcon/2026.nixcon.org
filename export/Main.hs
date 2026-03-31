module Main where

import Data.Default (def)
import Effectful
import Test.Dramaturge
import Prelude hiding (writeFile)

main :: IO ()
main = runEff . runDramaturge def $ do
    newSession
    navigate "http://localhost:8080"
    waitForElement $ ByCSS "body > *"
    saveSource "index.html"
