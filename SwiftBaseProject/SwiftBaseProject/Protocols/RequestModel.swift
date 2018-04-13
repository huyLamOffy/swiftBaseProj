import Foundation

/// All requests must conform to this protocol
/// - Discussion: You must conform to Encodable too, so that all stored public parameters
///   of types conforming this protocol will be encoded as parameters.
public protocol RequestModelProtocol: Encodable {
    /// Response (will be wrapped with a DataContainer)
    associatedtype Response: Decodable
    func toParameters() throws -> [String : Any]?
}

extension RequestModelProtocol where Self : Encodable {
    func toParameters() throws -> [String : Any]? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let data = try jsonEncoder.encode(self)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
    }
}


