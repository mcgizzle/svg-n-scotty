module Colour where

data Colour = Black
            | White
            | Blue
            | Green
            | Red

instance Show Colour where
  show White = "white"
  show Black = "black"
  show Blue = "blue"
  show Green = "green"
  show Red = "red"

black = Black
white = White
blue = Blue
green = Green
red = Red
