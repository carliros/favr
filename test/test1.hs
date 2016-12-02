module Main where

main :: IO()
main = do setupArduino
          start



{-
El primer problema que estoy teniendo es:
* ¿Cómo escribir arduino en Haskell ?

Things we need to do:
1. Setup pins as INPUT, OUTPUT == pinMode(pin, Mode) in arduino
2. Do a while cycle
3. Read Arduino State == this should be IO action == digitalRead(PinNumber) in C programming
4. Write Arduino State == this should be IO action == digitalWrite(PinNumber, Bool value) in C Programming
-}
