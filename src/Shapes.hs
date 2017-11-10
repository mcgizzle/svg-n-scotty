module Shapes  where

import Data.Map as Map
import Data.Maybe
import Text.Blaze.Svg as S hiding (matrix)
-- Utilities
data Vector = Vector Double Double
              deriving Show
vector = Vector

cross :: Vector -> Vector -> Double
cross (Vector a b) (Vector a' b') = a * a' + b * b'

mult :: Matrix -> Vector -> Vector
mult (Matrix r0 r1) v = Vector (cross r0 v) (cross r1 v)

invert :: Matrix -> Matrix
invert (Matrix (Vector a b) (Vector c d)) = matrix (d / k) (-b / k) (-c / k) (a / k)
  where k = a * d - b * c
        
-- 2x2 square matrices are all we need.
data Matrix = Matrix Vector Vector
              deriving Show

matrix :: Double -> Double -> Double -> Double -> Matrix
matrix a b c d = Matrix (Vector a b) (Vector c d)

getX (Vector x y) = x
getY (Vector x y) = y


-- Shapes

type Point  = Vector

point :: Double -> Double -> Point
point = vector


data Shape = Circle 
             deriving Show
circle = Circle

-- Transformations

data Transform = Identity
           | Translate Vector
           | Scale Vector
           | Compose Transform Transform
           | Rotate Matrix
           | Fill Colour
           | Border Colour
           | BorderWidth Colour
             deriving Show

identity = Identity
translate = Translate
scale = Scale
rotate angle = Rotate $ matrix (cos angle) (-sin angle) (sin angle) (cos angle)
t0 <+> t1 = Compose t0 t1
fill = Fill
border = Border
borderWidth = borderWidth

transform :: Transform -> Point -> Point
transform Identity                   x = id x
transform (Translate (Vector tx ty)) (Vector px py)  = Vector (px - tx) (py - ty)
transform (Scale (Vector tx ty))     (Vector px py)  = Vector (px / tx)  (py / ty)
transform (Rotate m)                 p = (invert m) `mult` p
transform (Compose t1 t2)            p = transform t2 $ transform t1 p

transformSvg :: Transform -> Map String String -> Map String String
transformSvg (Fill c) m = Map.insert "fill" c m
transformSvg (Border c) m = Map.insert "stroke" c m
transformSvg (BorderWidth w) m = Map.insert "strokeWidth" w m
transformSvg (Scale (Vector x y)) m = Map.insert "height" sy $ Map.insert "width" sx m
  where 
    sy = show $ y * readNum "height" m
    sx = show $ x * readNum "width" m

transformSvg (Compose t1 t2) m = transformSvg t2 $ transformSvg t1 m

readNum :: String ->  Map String String -> Double
readNum s m = read $ fromJust $ Map.lookup s m 
-- Design
type Width = Int
type Colour = String

-- Drawing
type Drawing = [(Transform,Shape)]

