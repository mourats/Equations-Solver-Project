module Read where

import System.Random
import System.IO.Unsafe(unsafeDupablePerformIO)
import Data.List.Split

randomValue :: Int -> Int
randomValue tam = unsafeDupablePerformIO (getStdRandom (randomR (1,tam))) 

logomarca :: String
logomarca = unsafeDupablePerformIO (readFile "data/logomarca.txt")


lerPrimeiroGrau :: String
lerPrimeiroGrau = do
    let file = unsafeDupablePerformIO (readFile "data/first-degree-equations-bd.txt")
    -- let matriz =  ((map ( splitOn ";") (lines file))) 
    return file !! 0

lerSegundoGrau :: String
lerSegundoGrau = do
    let file = unsafeDupablePerformIO (readFile "data/second-degree-equations-bd.txt")
    -- let matriz =  ((map ( splitOn ";") (lines file))) 
    return file !! 0 
