module Main where

import Shapes
import Render 
import Ansi
import Server

--exampleDrawing =  [ (scale (point 0.5 0.25) <+> translate (point 1.2 0.4), circle) ]
exampleDrawing =  [ (scale (vector 10 3), circle) ]

main = serve $ initSvg exampleDrawing
 
