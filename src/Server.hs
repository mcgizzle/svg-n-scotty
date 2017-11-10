{-# LANGUAGE OverloadedStrings #-}

module Server where

import Web.Scotty
import Prelude hiding (head)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes 
import qualified Text.Blaze.Html.Renderer.Pretty as P

import Data.Text.Lazy

import Render


serve s = scotty 3000 $ get "/" $ html $ pack $ P.renderHtml $ render s


--renderImage :: html
render s = H.docTypeHtml $ do
  H.head $ H.title "Works"
  H.body $ do
    H.h1 "Gorge shape"
    s
