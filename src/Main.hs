module Main where

import Render 
import Server
import Shapes
import Style
import Colour

exampleDrawing =  [ (scale 30 30 <+> translate 40 10, circle, fill red <%> strokeWidth 1.0), 
                    (scale 50 50 <+> rotate 120, square, fill blue <%> strokeWidth 2.0 <%> stroke green)]

main = serve 
 
