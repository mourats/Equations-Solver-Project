module Util where

import System.Random
import System.IO.Unsafe(unsafeDupablePerformIO)

randomValue :: Int -> Int
randomValue tam = unsafeDupablePerformIO (getStdRandom (randomR (0,tam - 1))) 

logomarca :: String
logomarca = unsafeDupablePerformIO (readFile "data/logomarca.txt")
