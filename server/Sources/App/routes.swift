import Routing
import Vapor

let ledStrip = LED()

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get("led/on") { req -> String in
        ledStrip.turnOn()
        return "OK"
    }

    router.get("led/off") { req -> String in
        ledStrip.turnOff()
        return "OK"
    }
}
