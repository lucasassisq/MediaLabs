import UIKit
import Core

// MARK: - Class

public final class MainCoordinator: Coordinator {

    // MARK: - Internal variables

    weak public var parent: Coordinator?
    public var children = [Coordinator]()
    public var navigationController: UINavigationController

    // MARK: - Initializers

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MainCoordinator {

    // MARK: Public methods

    public func start() {
        startWeatherScreen()
    }

    // MARK: - Private methods

    private func startWeatherScreen() {

        // MARK: - Initialize here your ViewController

        let viewModel = WeatherViewModel(coordinator: self)
        let viewController = WeatherViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

}
