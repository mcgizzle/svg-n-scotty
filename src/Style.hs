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
                deriving (Show,Read)
fill = Fill
stroke = Stroke
strokeWidth = Width
t1 <%> t2 = Glue t1 t2

-- Default Style which is used in case not all values are passed into the DSL
defaultStyle :: Style
defaultStyle = Style white black 2.0 

-- Pattern matches out the styles updating the style sheet
setStyle :: StyleTrans -> Style -> Style
setStyle (Fill c)     (Style _ s w) = Style c s w 
setStyle (Stroke s)   (Style c _ w) = Style c s w
setStyle (Width w)    (Style c s _) = Style c s w
setStyle (Glue t1 t2) s             = setStyle t1 $ setStyle t2 s

-- Converts the styles to their respective AttributeValue
getStroke :: Style -> AttributeValue
getStroke (Style _ c _) = stringValue $ show c

getWidth :: Style -> AttributeValue
getWidth (Style _ _ w) = stringValue $ show w

getFill :: Style -> AttributeValue
getFill (Style c _ _) = stringValue $ show c
