import UIKit
import Core
import Main

// MARK: - Class

final class AppCoordinator: Coordinator {

    // MARK: - Internal variables

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AppCoordinator {

    // MARK: Internal methods

    func start() {
        startConfigScreen()
    }

    private func startConfigScreen() {
        navigationController.isNavigationBarHidden = true
        let coord = MainCoordinator(navigationController: navigationController)
        add(coord)
        coord.parent = self
        coord.start()
    }
}
