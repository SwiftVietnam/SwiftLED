import AWSLambdaRuntime
import AWSLambdaEvents
import Foundation

struct Input: Codable {
    let name: String
}
   
struct Output: Codable {
    let hello: String
}

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()
   
Lambda.run { (context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in

    let response: APIGateway.V2.Response
    
    switch (request.context.http.path, request.context.http.method) {
      case ("/status", .GET):
        let body = try! jsonEncoder.encodeAsString(Output(hello: "get"))
        response = APIGateway.V2.Response(
            statusCode: .ok,
            multiValueHeaders: [
                "content-type": ["application/json"],
                "Access-Control-Allow-Origin": ["*"]
            ],
            body: body)
      case ("/status", .POST):
        let body = try! jsonEncoder.encodeAsString(Output(hello: "post"))
        response = APIGateway.V2.Response(
            statusCode: .ok,
            multiValueHeaders: [
                "content-type": ["application/json"],
                "Access-Control-Allow-Origin": ["*"]
            ],
            body: body)
      default:
        return callback(.success(APIGateway.V2.Response(statusCode: .notFound)))
    }
    
    callback(.success(response))
}

extension JSONEncoder {
    func encodeAsString<T: Encodable>(_ value: T) throws -> String {
        try String(decoding: self.encode(value), as: Unicode.UTF8.self)
    }
}
   
extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        try self.decode(type, from: Data(string.utf8))
    }
}
