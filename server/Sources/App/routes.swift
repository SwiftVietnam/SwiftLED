import Routing
import Vapor

let ledStrip = LED()

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    
    router.get("") { req -> Future<View> in
        return try req.view().render("home")
      }
    
    router.get("led/on") { req -> Response in
        ledStrip.turnOn()
        return req.redirect(to: "http://raspberrypi.local:8080")
    }

    router.get("led/off") { req -> Response in
        ledStrip.turnOff()
        return req.redirect(to: "http://raspberrypi.local:8080")
    }
}
