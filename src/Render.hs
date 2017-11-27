{-# LANGUAGE OverloadedStrings #-}
module Render(render) where

import Style hiding (fill,stroke,strokeWidth)

import Shapes hiding (circle,scale)
import Text.Blaze.Svg11 hiding (scale)
import Text.Blaze.Svg11.Attributes as SA 

-- Adds the headers needed to generate an Svg image 
render :: Drawing -> Svg
render x = docTypeSvg ! version "1.1" ! width "500" ! height "500" ! viewbox "-25 -25 50 50" $ render' x

-- Steps though each shape passed in and applys renderDrawing to it
render' :: Drawing -> Svg
render' [x] = renderDrawing x
render' (x:xs) = render' [x] >> render' xs

-- Takes in a Shape, transforms, style components and creates the relevant Svg
-- Each AttributeValue is converted to an Attribute
renderDrawing :: (Transform,Shape,StyleTrans) -> Svg
renderDrawing (trans,shape,sTrans) = renderShape shape ! 
                                    renderTransform trans ! 
                                    SA.fill (getFill style) !
                                    SA.strokeWidth (getWidth style) ! 
                                    SA.stroke (getStroke style) !
                                    customAttribute "vector-effect" "non-scaling-stroke"
                                      
  where style = setStyle sTrans defaultStyle

renderShape :: Shape -> Svg
renderShape Circle = circle ! r "1"
renderShape Square = rect ! width "1" ! height "1"
renderShape Empty  = rect

-- Wraps each transform in a `transform=''` tag, for example:
-- transform='scale(5 10) translate(2 3)'
renderTransform :: Transform -> Attribute
renderTransform trans = SA.transform $ mconcat $ Shapes.transform trans

