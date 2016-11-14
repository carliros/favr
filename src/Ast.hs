module Ast where

data HaskellAst
  = LetIn { letIdentifier :: String
          , letValue :: Expression
          , inExp :: Expression}
  deriving Show

data Expression
  = Literal {value :: AtomicValue}
  | SumFunction {left :: AtomicValue, right :: AtomicValue}
  deriving Show

data AtomicValue
  = BoolValue Bool
  | IntValue Int
  | StringValue String
  deriving Show
