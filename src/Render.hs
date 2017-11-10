{-# LANGUAGE OverloadedStrings #-}


module Render where
import Ansi as A
import Shapes hiding (circle,fill)
import Text.Blaze (toMarkup)
import Text.Blaze.Svg

import Text.Blaze.Svg11 hiding (title,toSvg)
import Text.Blaze.Svg11.Attributes hiding (title)

import Data.Map as Map hiding ((!))
import Data.Maybe

defaultMap :: Map String String
defaultMap = Map.fromList [("shape","circle"),("fill","white"),("stroke","black"),("strokeWidth","2"),("cy","50"),("cx","50"),("r","400"),("width","500"),("heigth","100")]

initSvg :: Drawing -> Svg
initSvg d = mkSvg d defaultMap

mkSvg :: Drawing -> Map String String -> Svg
mkSvg [(trans,s)] svgMap = svg ! width (get "width") ! height (get "heigth") $
          circle ! cx (get "cx") ! cy (get "cy") ! r (get "r") ! stroke (get "stroke") ! strokeWidth (get "strokeWidth") ! fill (get "fill")
          where get s = extractVal s $ transformSvg trans svgMap

extractVal :: String -> Map String String -> AttributeValue
extractVal s m = stringValue $ fromJust $ Map.lookup s m
