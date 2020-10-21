import SwiftyGPIO
import Foundation
import WS281x

class LED {

    private let strip: WS281x
    private let numberOfLeds = 8
    private(set) var isOn: Bool = false

    init() {
        let pwms = SwiftyGPIO.hardwarePWMs(for: .RaspberryPiPlusZero)!
        let pwm = (pwms[0]?[.P18])!

        self.strip = WS281x(
            pwm,
            type: .WS2812B,
            numElements: numberOfLeds
        )
    }

    private(set) var color: UInt32 = 0xFFFFFF

    func turnOff() {
        strip.setLeds([UInt32](repeating: 0x0, count: numberOfLeds))
        isOn = false
        strip.start()
        strip.wait()
    }

    func turnOn() {
        strip.setLeds([UInt32](repeating: color, count: numberOfLeds))
        isOn = true
        strip.start()
        strip.wait()
    }

    func set(_ newColor: HSV) {
        self.color = newColor.rbgUInt
        strip.setLeds([UInt32](repeating: self.color, count: numberOfLeds))
        strip.start()
        strip.wait()
    }

}
