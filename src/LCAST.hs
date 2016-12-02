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


-- taken from http://www.stephendiehl.com/llvm/#the-basic-language
type Name = String

data Expr
  = Float Double
  | BinOp Op Expr Expr
  | Var String
  | Call Name [Expr]
  | Function Name [Expr] Expr
  | Extern Name [Expr]
  deriving (Eq, Ord, Show)

data Op
  = Plus
  | Minus
  | Times
  | Divide
  deriving (Eq, Ord, Show)
