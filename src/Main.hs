module Main where

import Render 
import Server
import Shapes
import Style
import Colour

exampleDrawing =  [ (scale 10 10 <+> rotate 90, circle, fill red <%> strokeWidth 0.5) ]

main = serve $ render exampleDrawing
 
