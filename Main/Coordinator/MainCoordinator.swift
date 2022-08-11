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
        startConfigScreen()
    }

    // MARK: - Private methods

    private func startConfigScreen() {

        // MARK: - Initialize here your ViewController

        let viewModel = ConfigEnvironmentViewModel(coordinator: self)
        let viewController = ConfigEnvironmentViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

}
