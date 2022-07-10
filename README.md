# FPGA-VGA-Driver

A simple program to drive a display using an FPGA through VGA. The program outputs a 640 x 480 signal at 60 hertz with 3-bit colour. 

I use an Intel Cyclone 10 LP FPGA; you may have to adjust the clock divider depending on the clock speed of your hardware. A clock speed of around 25 gigahertz is necessary to generate the correct timings. Ben Eater has a good video explaining VGA signal timings: https://www.youtube.com/watch?v=l7rce6IQDWs. Timings for other resolutions can be found here: http://tinyvga.com/vga-timing

## Inputs

|Name|Use|Voltage|Milliamps|
|----|---|-------|--------|
|clk|clock signal|2.5|2|
 

## Outputs: 
|Name|Use|Voltage|Milliamps|
|----|---|-------|--------|
|hSync|horizontal synchronization|3.3 volts|maximum current|
|vSync|vertical synchronization|3.3 volts|maximum current|  
|RGB[2]|red|3.3 volts| maximum current| 
|RGB[1]|green|3.3 volts|maximum current| 
|RGB[0]|blue|3.3 volts|maximum current|  
