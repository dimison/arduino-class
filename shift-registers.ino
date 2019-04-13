/*
    Copyright (C) 2019 by John M. Beck <john.morris.beck@gmail.com>
    Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.
    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
    SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
    NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
    THIS SOFTWARE.
    
*/

/*


 (                          (                                            
 )\ )    )     (        )   )\ )                        )                
(()/( ( /( (   )\ )  ( /(  (()/(   (   (  (  (       ( /(   (   (        
 /(_)))\()))\ (()/(  )\())  /(_)) ))\  )\))( )\  (   )\()) ))\  )(   (   
(_)) ((_)\((_) /(_))(_))/  (_))  /((_)((_))\((_) )\ (_))/ /((_)(()\  )\  
/ __|| || |(_) | _|| | _   | _ \(_))   (()(_)(_)((_)| |_ (_))   ((_)((_) 
\__ \| __ || | |_||    _|  |   // -_) / _` | | |(_-<|  _|/ -_) | '_|(_-< 
|___/|_||_||_| |_|   \__|  |_|_\\___| \__, | |_|/__/ \__|\___| |_|  /__/
                                      |___/

Shift registers can be chained to extend the digital pins of your controller (like an arduino or a raspberry pi).

Here is a guide to a very specific shift register for a very specific class. Your shift register may vary.

This shift register converts 3 digital pins into 8 digital pins. For each additional shift register you chain
you gain 8 more digital pins.

Guide:

The circle in the top left indicates the direction of the chip. When counting
pins make sure it is aligned with that circle. The circle can be found physically
on the shifter.

Keep in mind that the shifters wayne gives might be different. Read the numbers
on them. Soon I will make a guide to those or may have already.

The shifter needs no resistors.

Type of pins:
numbers - Pins that can go on and off
ground - must go to ground. negative side. There are two of these.
power - must recieve power. positive side. There are two of these.
data - data pin. At least one of these must go on the arduino.
clock - clock pin. At least one of these must go on the arduino.
latch - latch pin. At least one of these must go on the arduino.

            *************
 1       ---*()         *---       power (see the circle in the top left?
            *           *          Your real life shifter has one like it on top.
            *           *
 2       ---*           *---       0 (notice that the zero is on the right of the board)
            *           *
            *           *
 3       ---*           *---       data
            *           *
            *           *
 4       ---*           *---       ground
            *           *
            *           *
 5       ---*           *---       latch
            *           *
            *           *
 6       ---*           *---       clock
            *           *
            *           *
 7       ---*           *---       power
            *           *
            *           *
 ground  ---*           *---       data passing (see below)
            *************


You can put shifters in series to extend the pins even further.

*/




/*

          If your code does not work try changing the next six values.

*/

//rename datapin clockpin and latchpin
int shift_data_pin = 2; 
int shift_clock_pin = 3;
int shift_latch_pin = 4;



byte shifter_data = 0; //need this for some reason
void sw(int pin, boolean HIGH_or_LOW){
  bitWrite(shifter_data,pin,HIGH_or_LOW); //write HIGH
  shiftOut(shift_data_pin, shift_clock_pin, MSBFIRST, shifter_data); //send it
  digitalWrite(shift_latch_pin, HIGH); //I dunno but need it
  digitalWrite(shift_latch_pin, LOW); //I dunno but need it
}
void shiftWrite(int pin, boolean HIGH_or_LOW){//easier to remember name
 shiftWrite(pin,HIGH_or_LOW);
}


void setup()
{
  pinMode(shift_data_pin, OUTPUT);
  pinMode(shift_clock_pin, OUTPUT);  
  pinMode(shift_latch_pin, OUTPUT);
}


void loop()
{ 
//change the number 0 to anything between 0 and 7
//you can go higher than 7 if you follow the guide to adding mroe shifters.
sw(0,HIGH);
delay(1000);
sw(0,LOW);
delay(1000);
}

