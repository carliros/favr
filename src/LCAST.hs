module LBAST where

data Expression
  = Expression {
        variable :: String
      , function :: Function
      , application ::Application
    }
  deriving Show

data Function
  = Function {name :: String, expression :: Expression}
  deriving Show

data Application
  = Application Expression Expression
  deriving Show
