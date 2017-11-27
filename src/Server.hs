{-# LANGUAGE OverloadedStrings #-}

module Server where

import Web.Scotty
import Prelude hiding (head)
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import Text.Blaze.Renderer.Text
import Shapes (Drawing)
import Render (render)
import Data.Either
import Data.Text.Lazy
import Text.Read (readMaybe)

-- Takes in the Text gathered from the POST request and uses Haskells derived read to convert it to the matching drawing
toShape :: Text -> Maybe Drawing
toShape = readMaybe . unpack 

-- Setup required for an Svg
showSvg drawing = do
  setHeader "Content-Type" "image/svg+xml"
  setHeader "Vary" "Accept-Encoding"
  raw $ renderSvg drawing

serve = scotty 3000 $ do
  
  -- Displays the form to submit shapes
  get "/" $ file "static/index.html"
 
 -- Gathers the POST parameters and checks if they can be read in
 -- If yes, it then passes them to the render function
  post "/display" $ do
    shapes <- (param "shape1") `rescue` return
    case toShape shapes of
      Just shapes' -> raw $ renderSvg $ render shapes'
      Nothing      -> html "<h1> You have submitted an incorrect shape, please check your shapes and try again <br>ps it's probably a parenthesis issue</h1>"
