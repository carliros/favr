.device ATmega328P
.org 0x0000
jmp Reset
.org 0x0020
jmp overflow_handler
Reset:
   ldi r16,0b00000101
   out 0x25,r16
   ldi r16,0x01
   out 0x6e,r16
   sei
   clr r16
   out 0x26,r16
   sbi 0x0a,0x04
   sbi 0x0b,0x04
Blink:
   sbi 0x0b,0x04
   rcall Delay
   cbi 0x0b,0x04
   rcall Delay
   rjmp Blink
Delay:
   clr r17
sec_count:
   cpi r17,0x1e
   brne sec_count
   ret
overflow_handler:
   inc r17
   cpi r17, 0x3d
   brne PC+2
   clr r17
   reti