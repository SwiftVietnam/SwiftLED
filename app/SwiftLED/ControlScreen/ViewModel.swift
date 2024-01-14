//
//  Copyright © 2020 SwiftVietnam. All rights reserved.
//

import Foundation

enum LEDState: String {
    case on
    case off
}

struct LampStatus: Codable {
    let status: Bool
}

enum LCDColor: String {
    case red
    case green
    case blue
}

class ViewModel {

    var date = Date()
    let url = URL(string: "http://pizero1.local:8080/")!
    var output: (() -> (String))?

    func `switch`(to state: LEDState, completion: @escaping (Bool) -> ()) {
        URLSession.shared.dataTask(with: url.appendingPathComponent("api/led/\(state.rawValue)")) { (json, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    NotificationBanner(with: error.localizedDescription, for: .failure).show()
                }
            }

            let success = error == nil
            completion(success)
        }.resume()
    }

    func change(hue: Int, saturation: Int, brightness: Int) {
        let now = Date()
        guard now.timeIntervalSince(date) > 0.2 else {
            return
        }
        URLSession.shared.dataTask(with: url.appendingPathComponent("api/color/\(hue)/\(saturation)/\(brightness)")).resume()
        date = now
    }

    func isOn(completion: @escaping (Bool) -> ()) {
        URLSession.shared.dataTask(with: url.appendingPathComponent("api/led/status")) { (json, response, error) in
            completion(true)
        }.resume()
    }

    func changeLCD( _ color: LCDColor, completion: @escaping (Bool) -> ()) {
        URLSession.shared.dataTask(with: url.appendingPathComponent("api/swiftio/lcd/\(color.rawValue)")) { (json, response, error) in
            completion(true)
        }.resume()
    }
}
