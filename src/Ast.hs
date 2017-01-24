

-- UUAGC 0.9.52.1 (src/Ast.ag)
module Ast where
-- AtomicValue -------------------------------------------------
data AtomicValue = BoolValue (Bool)
                 | IntValue (Int)
                 | StringValue (String)
                 deriving ( Show)
-- Expression --------------------------------------------------
data Expression = Literal (AtomicValue)
                | SumFunction (AtomicValue) (AtomicValue)
                deriving ( Show)
-- HaskellAst --------------------------------------------------
data HaskellAst = LetIn (String) (Expression) (Expression)
                deriving ( Show)