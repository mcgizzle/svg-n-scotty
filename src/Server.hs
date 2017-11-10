{-# LANGUAGE OverloadedStrings #-}

module Server where

import Web.Scotty
import Prelude hiding (head)
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)

r drawing = do
  setHeader "Content-Type" "image/svg+xml"
  setHeader "Vary" "Accept-Encoding"
  raw $ renderSvg drawing

serve = scotty 3000 . get "/" . r 

