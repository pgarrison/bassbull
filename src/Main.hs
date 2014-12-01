module Main where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Foldable as F
-- from cassava
import Data.Csv.Streaming

type BaseballStats = (BL.ByteString, Int, BL.ByteString, Int)

baseballStats :: BL.ByteString -> Records BaseballStats
baseballStats = decode NoHeader

fourth :: (a, b, c, d) -> d
fourth (_, _, _, x) = x

main :: IO ()
main = do
  csvData <- BL.readFile "batting.csv"
  let summed = F.foldr summer 0 (baseballStats csvData)
  putStrLn $ "Total at bats was: " ++ (show summed)
  where summer = (+) . fourth
