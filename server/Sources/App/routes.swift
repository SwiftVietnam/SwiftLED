import Routing
import Vapor

let ledStrip = LED()
var currentHue: Float = 360
var currentSaturation: Float = 0
var currentBrightness: Float = 1

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

    router.get("api/led/on") { req -> Response in
        ledStrip.turnOn()
        return Response(http: HTTPResponse(status: .ok), using: req)
    }

    router.get("api/led/off") { req -> Response in
        ledStrip.turnOff()
        return Response(http: HTTPResponse(status: .ok), using: req)
    }

    router.get("api/color", Float.parameter, Float.parameter, Float.parameter) { req -> Response in
        currentHue = try req.parameters.next(Float.self)
        currentSaturation = try req.parameters.next(Float.self) / 100
        currentBrightness = try req.parameters.next(Float.self) / 100
        ledStrip.set(HSV(h: currentHue, s: currentSaturation, v: currentBrightness))
        return Response(http: HTTPResponse(status: .ok), using: req)
    }

}

