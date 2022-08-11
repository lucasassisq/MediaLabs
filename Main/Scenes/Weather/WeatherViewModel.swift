import Core
import UIKit

// MARK: - Class

final class WeatherViewModel: ViewModel {

    // MARK: - Private variables

    private let coordinator: MainCoordinator
    private let service = WeatherService(service: ServiceManager())

    // MARK: - Internal variables

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(coordinator: coordinator)
    }
}

// MARK: - Extension

extension WeatherViewModel {

    // MARK: - Internal methods

    func getWeather(completion: @escaping (Result<WeatherResponse, ResponseError>) -> Void) {
        service.getWeather(completion: completion)
    }
}
