-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a BSD license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.ReplicationController
    ( ReplicationController (..)
    , kind
    , apiVersion
    , metadata
    , spec
    , status
    ) where

import           Control.Lens.TH (makeLenses)
import           Data.Aeson.TH (deriveJSON, defaultOptions, fieldLabelModifier)
import           Data.Text (Text)
import           GHC.Generics (Generic)
import           Prelude hiding (drop, error, max, min)
import qualified Prelude as P
import           Test.QuickCheck (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()
import           Kubernetes.Model.V1.ObjectMeta (ObjectMeta)
import           Kubernetes.Model.V1.ReplicationControllerSpec (ReplicationControllerSpec)
import           Kubernetes.Model.V1.ReplicationControllerStatus (ReplicationControllerStatus)

-- | ReplicationController represents the configuration of a replication controller.
data ReplicationController = ReplicationController
    { _kind :: Maybe Text
    , _apiVersion :: Maybe Text
    , _metadata :: Maybe ObjectMeta
    , _spec :: Maybe ReplicationControllerSpec
    , _status :: Maybe ReplicationControllerStatus
    } deriving (Show, Eq, Generic)

makeLenses ''ReplicationController

$(deriveJSON defaultOptions{fieldLabelModifier = P.drop 1} ''ReplicationController)

instance Arbitrary ReplicationController where
    arbitrary = ReplicationController <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary