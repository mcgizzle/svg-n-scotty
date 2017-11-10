{-# LANGUAGE OverloadedStrings #-}
module Render(render) where

import Style hiding (fill,stroke,strokeWidth)

import Shapes hiding (circle)
import Text.Blaze.Svg
import Text.Blaze.Svg11 
import Text.Blaze.Svg11.Attributes

render :: Drawing -> Svg
render [x] = renderHeader $ renderDrawing x
render (x:xs) = render [x] >> render xs

renderHeader :: Svg -> Svg
renderHeader = docTypeSvg ! version "1.1" ! viewbox "-25 -25 100 100" 

renderDrawing :: (Transform,Shape,StyleTrans) -> Svg
renderDrawing (trans,shape,sTrans) = renderShape shape ! strokeWidth (getWidth style) ! stroke (getStroke style) ! fill (getFill style)
  where style = setStyle sTrans defaultStyle

renderShape :: Shape -> Svg
renderShape Circle = circle ! r "30" ! cx "10" ! cy "10" 
renderShape Square = rect ! width "20" ! height "20"
renderShape Empty = rect

