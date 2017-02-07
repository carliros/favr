module Main where
import           Ast
import           CodeGen
import           Data.List
import           Numeric
import           Parser
import           System.Environment
import           System.FilePath
import           System.IO

main :: IO ()
main = do
  putStrLn "Functional AVR Compiler"
  args <- getArgs
  if null args
    then print "No file to compile."
    else do let file = head args
            result <- parseFile file
            let genCodeList = sem_Root (Root result)
                genCodeString = unlines genCodeList
                newFileName = replaceExtension file "asm"
            writeFile newFileName genCodeString
