{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified API (api)
import Control.Monad.IO.Class (liftIO)
import Web.Scotty (body, post, raw, scotty)

main :: IO ()
main = scotty 3000 $ post "/api" $ raw =<< (liftIO . API.api =<< body)