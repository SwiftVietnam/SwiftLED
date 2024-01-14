// Connect the USB-Serial converter module to your computer 
// and choose the port in serial monitor.
// Send message (1/0) from computer to turn on/off the LED.

import SwiftIO
import MadBoard
import ST7789

let uart = UART(Id.UART0)

// Initialize the SPI pin and the digital pins for the LCD.
let bl = DigitalOut(Id.D2)
let rst = DigitalOut(Id.D12)
let dc = DigitalOut(Id.D13)
let cs = DigitalOut(Id.D5)
let spi = SPI(Id.SPI0, speed: 30_000_000)

// Initialize the LCD using the pins above. Rotate the screen to keep the original at the upper left.
let screen = ST7789(spi: spi, cs: cs, dc: dc, rst: rst, bl: bl, rotation: .angle90)

// Store some color values for easier reference later.
let red   = UInt16(0xF800).byteSwapped
let green = UInt16(0x07E0).byteSwapped
let blue = UInt16(0x001F).byteSwapped

while true {
    // Check if there is any message from computer.
    let count = uart.checkBufferReceived()
    
    if count > 0 {
        // Read data from UART buffer.
        var buffer = [UInt8](repeating: 0, count: count)
        uart.read(into: &buffer)
        
        // Decode the data since the text from computer is sent in UTF8 format.
        let command = String(decoding: buffer, as: UTF8.self)
        // Connect the port on your micro board in serial monitor to see printed message
        print(command)
        
        // Set digital output according to the command from computer.
        switch command  {
        case "0": screen.clearScreen(red)
        case "1": screen.clearScreen(green)
        case "2": screen.clearScreen(blue)
        default: break
        }
    }
    
    sleep(ms: 10)
}
