module Main where
import           Ast
import           CodeGen
import           Data.List
import           Numeric
import           Options.Applicative
import           Parser
import           System.Environment
import           System.FilePath
import           System.IO

data FAvrOptions
  = FAvrOptions { output :: Maybe String
                , source :: String
                , device :: Device
                }

pFAvr :: Parser FAvrOptions
pFAvr = FAvrOptions
  <$> optional (strOption (long "output" <> short 'o' <> metavar "FILE" <> help "Write output to FILE"))
  <*> strArgument (metavar "SOURCE")
  <*> option deviceReader (long "device" <> short 'd' <> value ATMega328P <> metavar "DEVICE" <> help "Specify the Arduino Device")

deviceReader ::ReadM Device
deviceReader
  = eitherReader $ \arg -> if arg == "ATMega328P"
                           then Right ATMega328P
                           else Left ("Can not parse '" ++ arg ++ "'")


processOptions :: FAvrOptions -> IO ()
processOptions (FAvrOptions Nothing src device)
  = compileFAvr (replaceExtension src "asm") src device
processOptions (FAvrOptions (Just output) src device)
  = compileFAvr output src device

compileFAvr :: String -> String -> Device -> IO()
compileFAvr output src device
  = do result <- parseFile src
       let genCodeList = sem_Root (Root result) device
           genCodeString = unlines genCodeList
       writeFile output genCodeString

main :: IO ()
main = execParser opts >>= processOptions
  where
    opts = info (helper <*> pFAvr)
                (fullDesc <> progDesc "Generate assembly code for AVR"
                          <> header "Functional AVR Compiler")
