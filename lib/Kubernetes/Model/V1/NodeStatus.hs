-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.NodeStatus
    ( NodeStatus (..)
    , capacity
    , allocatable
    , phase
    , conditions
    , addresses
    , daemonEndpoints
    , nodeInfo
    , images
    , mkNodeStatus
    ) where

import           Control.Lens.TH                         (makeLenses)
import           Data.Aeson.TH                           (defaultOptions,
                                                          deriveJSON,
                                                          fieldLabelModifier)
import           Data.Text                               (Text)
import           GHC.Generics                            (Generic)
import           Kubernetes.Model.V1.Any                 (Any)
import           Kubernetes.Model.V1.ContainerImage      (ContainerImage)
import           Kubernetes.Model.V1.NodeAddress         (NodeAddress)
import           Kubernetes.Model.V1.NodeCondition       (NodeCondition)
import           Kubernetes.Model.V1.NodeDaemonEndpoints (NodeDaemonEndpoints)
import           Kubernetes.Model.V1.NodeSystemInfo      (NodeSystemInfo)
import           Prelude                                 hiding (drop, error,
                                                          max, min)
import qualified Prelude                                 as P
import           Test.QuickCheck                         (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances               ()

-- | NodeStatus is information about the current status of a node.
data NodeStatus = NodeStatus
    { _capacity        :: !(Maybe Any)
    , _allocatable     :: !(Maybe Any)
    , _phase           :: !(Maybe Text)
    , _conditions      :: !(Maybe [NodeCondition])
    , _addresses       :: !(Maybe [NodeAddress])
    , _daemonEndpoints :: !(Maybe NodeDaemonEndpoints)
    , _nodeInfo        :: !(Maybe NodeSystemInfo)
    , _images          :: !([ContainerImage])
    } deriving (Show, Eq, Generic)

makeLenses ''NodeStatus

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''NodeStatus)

instance Arbitrary NodeStatus where
    arbitrary = NodeStatus <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a NodeStatus
mkNodeStatus :: [ContainerImage] -> NodeStatus
mkNodeStatus ximagesx = NodeStatus Nothing Nothing Nothing Nothing Nothing Nothing Nothing ximagesx
