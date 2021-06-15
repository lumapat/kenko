{-# language DataKinds             #-}
{-# language FlexibleContexts      #-}
{-# language OverloadedStrings     #-}
{-# language PartialTypeSignatures #-}
{-# language PolyKinds             #-}
{-# language ScopedTypeVariables   #-}
{-# language TemplateHaskell       #-}
{-# language TypeApplications      #-}
{-# language TypeFamilies          #-}
{-# language TypeOperators         #-}
{-# OPTIONS_GHC -fno-warn-partial-type-signatures #-}

module Main where

import           Data.Proxy

import           Mu.GraphQL.Quasi
import           Mu.GraphQL.Server
import           Mu.Server

graphql "ServiceDefinition" "schema.graphql"
serverPort = 8000

-- GraphQL App

main :: IO ()
main = do
    putStrLn $ "Starting GraphQL server on port " ++ show serverPort
    runGraphQLAppQuery serverPort server (Proxy @"Query")

type ServiceMapping = '[]

server :: MonadServer m => ServerT ServiceMapping i ServiceDefinition m _
server = resolver ( object @"Query" ( method @"hello" $ pure $ Just "Tada!!" ) )