-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.PersistentVolumeList
    ( PersistentVolumeList (..)
    , kind
    , apiVersion
    , metadata
    , items
    ) where

import           Control.Lens.TH                       (makeLenses)
import           Data.Aeson.TH                         (defaultOptions,
                                                        deriveJSON,
                                                        fieldLabelModifier)
import           Data.Text                             (Text)
import           GHC.Generics                          (Generic)
import           Kubernetes.Model.Unversioned.ListMeta (ListMeta)
import           Kubernetes.Model.V1.PersistentVolume  (PersistentVolume)
import           Prelude                               hiding (drop, error, max,
                                                        min)
import qualified Prelude                               as P
import           Test.QuickCheck                       (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances             ()

-- | PersistentVolumeList is a list of PersistentVolume items.
data PersistentVolumeList = PersistentVolumeList
    { _kind       :: Maybe Text
    , _apiVersion :: Maybe Text
    , _metadata   :: Maybe ListMeta
    , _items      :: [PersistentVolume]
    } deriving (Show, Eq, Generic)

makeLenses ''PersistentVolumeList

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''PersistentVolumeList)

instance Arbitrary PersistentVolumeList where
    arbitrary = PersistentVolumeList <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
