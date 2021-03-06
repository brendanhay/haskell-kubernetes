-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.NodeList
    ( NodeList (..)
    , kind
    , apiVersion
    , metadata
    , items
    , mkNodeList
    ) where

import           Control.Lens.TH                       (makeLenses)
import           Data.Aeson.TH                         (defaultOptions,
                                                        deriveJSON,
                                                        fieldLabelModifier)
import           Data.Text                             (Text)
import           GHC.Generics                          (Generic)
import           Kubernetes.Model.Unversioned.ListMeta (ListMeta)
import           Kubernetes.Model.V1.Node              (Node)
import           Prelude                               hiding (drop, error, max,
                                                        min)
import qualified Prelude                               as P
import           Test.QuickCheck                       (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances             ()

-- | NodeList is the whole list of all Nodes which have been registered with master.
data NodeList = NodeList
    { _kind       :: !(Maybe Text)
    , _apiVersion :: !(Maybe Text)
    , _metadata   :: !(Maybe ListMeta)
    , _items      :: !([Node])
    } deriving (Show, Eq, Generic)

makeLenses ''NodeList

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''NodeList)

instance Arbitrary NodeList where
    arbitrary = NodeList <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a NodeList
mkNodeList :: [Node] -> NodeList
mkNodeList xitemsx = NodeList Nothing Nothing Nothing xitemsx
