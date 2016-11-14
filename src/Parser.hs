{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

module Parser where

import Data.Char
import Text.ParserCombinators.UU
import Text.ParserCombinators.UU.Utils
import Text.ParserCombinators.UU.BasicInstances hiding (Parser)
import System.IO
import GHC.IO.Handle.Types
import Ast

parseFile :: FilePath -> IO HaskellAst
parseFile file
  = do content <- readFile file
       let result = runParser file pMain content
       return result

pMain = pSpaces *> pProgram <* pSpaces

pProgram = LetIn <$ pSymbol "let" <*> pIdentifier
                    <* pSymbol "="  <*> pExpression
                    <* pSymbol "in" <*> pExpression

pExpression = pLiteral <|> pSumFunction

pLiteral = Literal <$> pAtomicValue

pIdentifier = lexeme (pList (pLetter <|> pDigit))

pAtomicValue =  BoolValue True <$ lexeme (pSymbol "True")
            <|> BoolValue False <$ lexeme (pSymbol "False")
            <|> IntValue <$> pInteger
            <|> StringValue <$> pQuotedString

pSumFunction = SumFunction <$> pAtomicValue <* pSymbol "+" <*> pAtomicValue
