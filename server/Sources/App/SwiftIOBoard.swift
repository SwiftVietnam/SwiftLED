import SwiftyGPIO
import Foundation

class SwiftIOBoard {

    private let uart: WS281x

    init() {
        let uarts = SwiftyGPIO.UARTs(for:.RaspberryPiPlusZero)!
        uart = uarts[0]

        uart.configureInterface(speed: .S115200, bitsPerChar: .Eight, stopBits: .One, parity: .None)
    }

    func displayRed() {
        uart.writeString("0")
    }

    func displayBlue() {
        uart.writeString("1")
    }

    func displayGreen() {
        uart.writeString("2")
    }
}
