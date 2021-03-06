-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.LocalObjectReference
    ( LocalObjectReference (..)
    , name
    , mkLocalObjectReference
    ) where

import           Control.Lens.TH           (makeLenses)
import           Data.Aeson.TH             (defaultOptions, deriveJSON,
                                            fieldLabelModifier)
import           Data.Text                 (Text)
import           GHC.Generics              (Generic)
import           Prelude                   hiding (drop, error, max, min)
import qualified Prelude                   as P
import           Test.QuickCheck           (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()

-- | LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace.
data LocalObjectReference = LocalObjectReference
    { _name :: !(Maybe Text)
    } deriving (Show, Eq, Generic)

makeLenses ''LocalObjectReference

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''LocalObjectReference)

instance Arbitrary LocalObjectReference where
    arbitrary = LocalObjectReference <$> arbitrary

-- | Use this method to build a LocalObjectReference
mkLocalObjectReference :: LocalObjectReference
mkLocalObjectReference = LocalObjectReference Nothing
