{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE Rank2Types                #-}
{-# LANGUAGE TypeSynonymInstances      #-}

module Parser where

import           Ast
import           GHC.IO.Handle.Types
import           System.IO
import           Text.ParserCombinators.UU
import           Text.ParserCombinators.UU.Utils

parseFile :: FilePath -> IO FAvr
parseFile file
  = do content <- readFile file
       let result = runParser file pMain content
       return result

pMain = pSpaces *> pMainProgram <* pSpaces

pMainProgram = MainFunction <$> pSymbol "main" <* pSymbol "=" <*> pList1Sep (pSymbol ">>") pIOAction

pIOAction = pDigitalWrite <|> pFunctionCall

pFunctionCall = FunctionCall <$> pIdentifier

pDigitalWrite = DigitalWrite <$ pSymbol "digitalWrite" <*> pPin <*> pBoolValue

pPin =     Pin1  <$ pSymbol "Pin1"
       <|> Pin2  <$ pSymbol "Pin2"
       <|> Pin3  <$ pSymbol "Pin3"
       <|> Pin4  <$ pSymbol "Pin4"
       <|> Pin5  <$ pSymbol "Pin5"
       <|> Pin6  <$ pSymbol "Pin6"
       <|> Pin7  <$ pSymbol "Pin7"
       <|> Pin8  <$ pSymbol "Pin8"
       <|> Pin9  <$ pSymbol "Pin9"
       <|> Pin10 <$ pSymbol "Pin10"
       <|> Pin11 <$ pSymbol "Pin11"
       <|> Pin12 <$ pSymbol "Pin12"
       <|> Pin13 <$ pSymbol "Pin13"

pBoolValue =     True  <$ pSymbol "True"
             <|> False <$ pSymbol "False"

pIdentifier = (:) <$> pLower <*> pList (pLower <|> pUpper <|> pDigit) <* pSpaces