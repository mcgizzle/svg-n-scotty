{-# LANGUAGE OverloadedStrings #-}

module Server where

import Web.Scotty
import Prelude hiding (head)
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import Shapes (Drawing)
import Render (render)
import Data.Either
import Data.Text.Lazy

toShape :: Text -> Drawing
toShape s = read (unpack s) :: Drawing

showSvg drawing = do
  setHeader "Content-Type" "image/svg+xml"
  setHeader "Vary" "Accept-Encoding"
  raw $ renderSvg drawing

serve = scotty 3000 $ do

  get "/" $ file "static/index.html"
 
  post "/display" $ do
    shapes <- (param "shape1") `rescue` return
    raw $ renderSvg $ render $ toShape shapes 
