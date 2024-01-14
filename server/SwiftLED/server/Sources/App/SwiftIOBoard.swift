import SwiftyGPIO
import Foundation

class SwiftIOBoard {

    private let uart: UARTInterface

    init() {
        uart = SysFSUART("ttyACM0")!
        //let uarts = SwiftyGPIO.UARTs(for:.RaspberryPiPlusZero)!
        //uart = uarts[0]

        uart.configureInterface(speed: .S115200, bitsPerChar: .Eight, stopBits: .One, parity: .None)
    }

    func displayRed() {
        uart.writeString("0")
        print("UART: write 0")
    }

    func displayBlue() {
        uart.writeString("1")
        print("UART: write 1")
    }

    func displayGreen() {
        uart.writeString("2")
        print("UART: write 2")
    }
}
