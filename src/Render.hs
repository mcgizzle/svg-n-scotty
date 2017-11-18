{-# LANGUAGE OverloadedStrings #-}
module Render(render) where

import Style hiding (fill,stroke,strokeWidth)

import Shapes hiding (circle,scale)
import Text.Blaze.Svg11 hiding (scale)
import Text.Blaze.Svg11.Attributes as SA 

render :: Drawing -> Svg
render [x] = renderHeader $ renderDrawing x
render (x:xs) = render [x] >> render xs

renderHeader :: Svg -> Svg
renderHeader = docTypeSvg ! version "1.1" ! viewbox "-25 -25 100 100" 

renderDrawing :: (Transform,Shape,StyleTrans) -> Svg
renderDrawing (trans,shape,sTrans) = renderShape shape ! 
                                    renderTransform trans ! 
                                    SA.fill (getFill style) !
                                    SA.strokeWidth (getWidth style) ! 
                                    SA.stroke (getStroke style) 
                                      
  where style = setStyle sTrans defaultStyle

renderShape :: Shape -> Svg
renderShape Circle = circle ! r "1"
renderShape Square = rect ! width "1" ! height "1"
renderShape Empty  = rect

renderTransform :: Transform -> Attribute
renderTransform trans = SA.transform $ mconcat $ Shapes.transform trans

