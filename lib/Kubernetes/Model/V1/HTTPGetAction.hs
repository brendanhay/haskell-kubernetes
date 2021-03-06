-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.HTTPGetAction
    ( HTTPGetAction (..)
    , path
    , port
    , host
    , scheme
    , mkHTTPGetAction
    ) where

import           Control.Lens.TH           (makeLenses)
import           Data.Aeson.TH             (defaultOptions, deriveJSON,
                                            fieldLabelModifier)
import           Data.Text                 (Text)
import           GHC.Generics              (Generic)
import           Kubernetes.Utils          (IntegerOrText)
import           Prelude                   hiding (drop, error, max, min)
import qualified Prelude                   as P
import           Test.QuickCheck           (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()

-- | HTTPGetAction describes an action based on HTTP Get requests.
data HTTPGetAction = HTTPGetAction
    { _path   :: !(Maybe Text)
    , _port   :: !(IntegerOrText)
    , _host   :: !(Maybe Text)
    , _scheme :: !(Maybe Text)
    } deriving (Show, Eq, Generic)

makeLenses ''HTTPGetAction

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''HTTPGetAction)

instance Arbitrary HTTPGetAction where
    arbitrary = HTTPGetAction <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a HTTPGetAction
mkHTTPGetAction :: IntegerOrText -> HTTPGetAction
mkHTTPGetAction xportx = HTTPGetAction Nothing xportx Nothing Nothing
