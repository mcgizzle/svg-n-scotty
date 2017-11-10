module Shapes  where

import Data.Map as Map
import Data.Maybe
import Text.Blaze.Svg11 as S
import Text.Blaze.Svg11.Attributes

import Style

-- Shapes
data Shape = Circle 
           | Square
           | Empty
             deriving Show

circle, square, empty :: Shape
empty = Shapes.Empty
square = Square
circle = Circle

-- Transformations
data Transform = Identity
           | Translate Double Double
           | Scale Double Double
           | Compose Transform Transform

identity = Identity
translate = Translate
scale = Scale
t0 <+> t1 = Compose t0 t1

transform :: Transform -> AttributeValue
--transform Identity        = S.Identity
transform (Translate x y) = S.translate x y
transform (Scale x y)     = S.scale x y
--transform (Compose t1 t2) = Shapes.transform t2 $ Shapes.transform t1 

-- Drawing
type Drawing = [(Transform,Shape,StyleTrans)]

