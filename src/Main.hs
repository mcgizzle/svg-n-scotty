module Main where

import Render 
import Server
import Shapes
import Style
import Colour

exampleDrawing =  [ (scale 30 30 <+> translate 40 10, circle, fill red <%> strokeWidth 0.1), 
                    (scale 50 50 <+> rotate 120, square, fill blue <%> strokeWidth 0.1 <%> stroke green)]

main = serve $ render exampleDrawing
 
