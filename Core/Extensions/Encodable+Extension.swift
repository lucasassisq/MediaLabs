import Alamofire

// MARK: - Encodable Extension

public extension Encodable {
    var asDictionary: Parameters? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters else {
            return nil
        }
        
        return dictionary
    }
}
