import Foundation
import RDCCore
import RDCBusiness

class StubNetworkManager: INetworkManaging {
    var mockValue: Any?
    var verifiedUrl: String?
    
    func get<T>(_ type: T.Type, from url: String) async throws -> T where T : Decodable {
        verifiedUrl = url
        
        if let mockDecodedValue = mockValue as? T {
            return mockDecodedValue
        }
        
        throw GenericError(message: "Invalid type requested")
    }
}
