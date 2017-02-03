# Functional Avr (Arduino)

**Project status**: initial, experimenting and continuous development

This a learning project to experiment how we can do functional programming for Arduino UNO.

### Initial objectives:

- Learning Asm Arduino
- Build a haskell-like syntax programming language for Arduino.

### Development


#### Build

~~~~
stack build
~~~~

#### Execute

~~~~
stack exec favr examples/ex1.favr
~~~~

#### Generate HEX and Upload to Arduino

Generate hex code

~~~~
avra ex1.asm
~~~~

Upload to Arduino connected to `/dev/cu.wchusbserial1410`

~~~~
avrdude -p m328p -c stk500v1 -b 115200 -P /dev/cu.wchusbserial1410 -U flash:w:ex1.hex -F
~~~~

#### Extra tools

- [avra - Atmel AVR Assembler](https://sourceforge.net/projects/avra/)
- [avrdude - AVR Downloader/UploaDEr](http://www.nongnu.org/avrdude/)


### Ideas

This is a chunk of an ideal code

~~~~
main = do digitalWrite Pin4 True

loop :: IO()
loop = do digitalWrite Pin4 True
          sleep 500
          digitalWrite Pin4 False
          loop

digitalWrite :: PortD -> Bool -> IO ()

data PortD
    = Pin1 | Pin2 | Pin3 | Pin4 | Pin5 | Pin6 | Pin7 | Pin8 | Pin9 | Pin10 | Pin11 | Pin12 | Pin13 
~~~~