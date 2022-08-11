import Foundation

// MARK: - Class

public class Url {
    
    // MARK: - Public variables
    
    public static let shared = Url()
    public var baseUrl = "https://api.openweathermap.org/data/2.5/" // Url base api
    public let appId = "d4277b87ee5c71a468ec0c3dc311a724"
}

public extension Url {
    
    // MARK: - Internal methods
    
    func configure(url: String) {
        self.baseUrl = url
    }
    
    func getDomain() -> String {
        let url = URL(string: self.baseUrl)?.host ?? ""
        return "https://"+url
    }
}
