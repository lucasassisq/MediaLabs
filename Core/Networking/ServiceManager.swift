import Alamofire

// MARK: - ServiceManager Protocol

public protocol ServiceManagerProtocol {
    func performRequest<T: Codable>(route: BaseRequestProtocol, completion: @escaping (Result<T, ResponseError>) -> Void)
}

// MARK: - Class

public class ServiceManager: SessionDelegate, ServiceManagerProtocol {
    
    // MARK: - Private variables
    
    private var session: Session?
    private var invalidCertificate = false
    
    // MARK: - Initializers
    
    public init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldUsePipelining = true

        session = Session.init(configuration: configuration,
                               delegate: self,
                               startRequestsImmediately: true)
    }
}

public extension ServiceManager {
    
    // MARK: - Public methods
    
    func performRequest<T: Codable>(route: BaseRequestProtocol,
                                    completion: @escaping (Result<T, ResponseError>) -> Void) {
        
        let encoding: ParameterEncoding = route.method == .get ? URLEncoding.default : JSONEncoding.default
        
        let headers: HTTPHeaders = [
//            "Cookie": Need Cookie? Put here.,
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8"
        ]
      
        print(headers)
        print(route.path)
        
        let task = self.beginBackgroundTask()
        
        self.session?.request(route.path,
                         method: route.method,
                         parameters: route.body,
                         encoding: encoding,
                         headers: route.headers == nil ? headers : route.headers)
            .validate()
            .responseDecodable(completionHandler: { (response: DataResponse<T, AFError>) in
                self.endBackgroundTask(taskID: task)
                let apiLink = response.request?.url?.absoluteString ?? ""
                
                debugPrint(response)
                debugPrint(apiLink)
                
                guard
                    let statusCode = response.response?.statusCode
                else {
                    let error = self.createGenericError()
                    completion(.failure(error))
                    return
                }
                
                switch response.result {
                    
                case .success(let response):
                    debugPrint(statusCode)
                    completion(.success(response))
                    
                case .failure(_):
                    let error = self.createGenericError()
                    completion(.failure(error))
                }
            })
        
    }
    
    func beginBackgroundTask() -> UIBackgroundTaskIdentifier {
        return UIApplication.shared.beginBackgroundTask(expirationHandler: {})
    }

    func endBackgroundTask(taskID: UIBackgroundTaskIdentifier) {
        UIApplication.shared.endBackgroundTask(taskID)
    }
}

extension ServiceManager {

    func createGenericError() -> ResponseError {
        return ResponseError(indicadorErro: 0,
                             codigoErro: "",
                             descricaoErro: "",
                             descricaoErroMobile: AppStrings.genericErrorMessage,
                             proximoPasso: 0)
    }
}

public struct ResponseError: Codable, Error {
    
    public enum CodingKeys: String, CodingKey {
        case indicadorErro = "IndicadorErro"
        case codigoErro = "CodigoErro"
        case descricaoErro = "DescricaoErro"
        case descricaoErroMobile = "DescricaoErroMobile"
        case proximoPasso = "ProximoPasso"
        case habilitarDesbloqueio = "HabilitarDesbloqueio"
        case mensagemDesbloqueio = "MensagemDesbloqueio"
        case urlRedirecionamento = "UrlRedirecionamento"
        case textoErroBotaoLogin = "TextoErroBotaoLogin"
        case textoErroBotaoRedirecionamento = "TextoErroBotaoRedirecionamento"
    }
    
    public let indicadorErro: Int
    public let codigoErro: String
    public let descricaoErro: String
    public let descricaoErroMobile: String
    public let proximoPasso: Int
    public var habilitarDesbloqueio: Bool?
    public var mensagemDesbloqueio: String?
    public var urlRedirecionamento: String?
    public var textoErroBotaoLogin: String?
    public var textoErroBotaoRedirecionamento: String?
    
    public init(indicadorErro: Int,
                codigoErro: String,
                descricaoErro: String,
                descricaoErroMobile: String,
                proximoPasso: Int) {
        
        self.indicadorErro = indicadorErro
        self.codigoErro = codigoErro
        self.descricaoErro = descricaoErro
        self.descricaoErroMobile = descricaoErroMobile
        self.proximoPasso = proximoPasso
    }
}
