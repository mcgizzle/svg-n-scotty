module Ansi where

data Colour = Black | Red | Green | Yellow | Blue | Magenta | Cyan | White
  deriving (Eq,Show,Enum)

cls :: IO ()
cls = putStr "\ESC[2J"

goto :: Int -> Int -> IO ()
goto x y    = putStr $ "\ESC[" ++ show y ++ ";" ++ show x ++ "H"

color :: Colour -> String -> IO ()
color c s = putStr $ "\ESC[3" ++ show (fromEnum c) ++ "m" ++ s ++ "\ESC[0m"

