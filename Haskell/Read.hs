module Read where

import System.Random
import System.IO.Unsafe(unsafeDupablePerformIO)
import Data.List.Split

randomValue :: Int -> Int
randomValue tam = unsafeDupablePerformIO (getStdRandom (randomR (0,tam - 1))) 

logomarca :: String
logomarca = unsafeDupablePerformIO (readFile "data/logomarca.txt")


lerPrimeiroGrau :: [String]
lerPrimeiroGrau = do
    let file = unsafeDupablePerformIO (readFile "data/first-degree-equations-bd.txt")
    let lista =  lines file
    return (lista !! 0)

lerSegundoGrau :: [String]
lerSegundoGrau = do
    let file = unsafeDupablePerformIO (readFile "data/second-degree-equations-bd.txt")
    let lista =  lines file
    return (lista !! 0)
