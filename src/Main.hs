module Main where

import Render 
import Server
import Shapes
import Style
import Colour

exampleDrawing =  [ (identity , circle, fill red <%> stroke blue <%> strokeWidth 5) ]

main = serve $ render exampleDrawing
 
