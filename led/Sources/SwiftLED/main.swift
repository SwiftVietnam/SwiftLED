import SwiftyGPIO
import WS281x
import Foundation

let pwms = SwiftyGPIO.hardwarePWMs(for: .RaspberryPiPlusZero)!
let pwm = (pwms[0]?[.P18])!

let numberOfLeds = 8

let w = WS281x(
    pwm, 
    type: .WS2812B,
    numElements: numberOfLeds
)

//var color: UInt32 = 0xFFFFFF
var color: UInt32 = 0x0

w.setLeds([UInt32](repeating: color, count: numberOfLeds))

w.start()

print("started")

w.wait()

print("done!")
