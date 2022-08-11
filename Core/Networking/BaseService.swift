
// MARK: - Class

open class BaseService {
        
    // MARK: - Public variables
    
    public let service: ServiceManagerProtocol
    
    // MARK: Initializer
    
    public init(service: ServiceManagerProtocol) {
        self.service = service
    }
}

// MARK: - Extension

public extension BaseService {
    
    // MARK: - Base Requests
    
    func createRequest(body: Codable? = nil, path: String, method: HttpMethod = .post, apiHeaders: Headers? = [:]) -> BaseRequestProtocol {
        let requestProtocol = BaseRequest(generic: body, apiPath: path, apiMethod: method, apiHeaders: apiHeaders)
        return requestProtocol
    }
}

// MARK: - BaseRequest

struct BaseRequest: BaseRequestProtocol {
    
    var method: HttpMethod
    
    var path: String
    
    var body: Parameters?
    
    var headers: Headers?
    
    init(generic: Codable? = nil, apiPath: String, apiMethod: HttpMethod, apiHeaders: Headers? = [:]) {
        path = Url.shared.baseUrl + apiPath
        method = apiMethod
        headers = apiHeaders
        guard let generic = generic else {
            body = [:]
            return
        }
        body = generic.asDictionary
    }
}
