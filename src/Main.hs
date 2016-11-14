module Main where
import System.Environment
import System.IO
import Parser

main :: IO ()
main = do
  putStrLn "Functional AVR Compiler"
  args <- getArgs
  if null args
    then print "No file to compile."
    else do let file = head args
            result <- parseFile file
            print result
