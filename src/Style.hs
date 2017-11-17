module Style where

import Text.Blaze.Svg11
import Text.Blaze.Svg11.Attributes 

import Colour

type Size = Double

data Style = Style Colour Colour Size

data StyleTrans = Fill Colour 
                | Stroke Colour 
                | Width  Size
                | Glue StyleTrans StyleTrans
fill = Fill
stroke = Stroke
strokeWidth = Width
t1 <%> t2 = Glue t1 t2

defaultStyle :: Style
defaultStyle = Style white black 2

setStyle :: StyleTrans -> Style -> Style
setStyle (Fill c)     (Style _ s w) = Style c s w 
setStyle (Stroke s)   (Style c _ w) = Style c s w
setStyle (Width w)    (Style c s _) = Style c s w
setStyle (Glue t1 t2) s             = setStyle t1 $ setStyle t2 s

getStroke :: Style -> AttributeValue
getStroke (Style _ c _) = stringValue $ show c

getWidth :: Style -> AttributeValue
getWidth (Style _ _ w) = stringValue $ show w

getFill :: Style -> AttributeValue
getFill (Style c _ _) = stringValue $ show c
