import UIKit
import RxSwift
import RxCocoa

// MARK: - Class

open class ViewModel {

    // MARK: - Private variables

    private var coordinator: Coordinator

    // MARK: - Initializer

    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Extension

public extension ViewModel {

    // MARK: - Public methods

    func back() {
        coordinator.back()
    }

    func backWithoutAnimation() {
        coordinator.backWithoutAnimation()
    }

    func backToVc<T: UIViewController>(_ viewController: T.Type) {
        coordinator.popToViewController(withDestinationViewControllerType: viewController.self)
    }

    func getViewControllerInStack(vc: UIViewController.Type) -> UIViewController? {
        if let viewController = coordinator.navigationController.viewControllers.first(where: { $0.isKind(of: vc.self) }) {
            return viewController
        }
        return nil
    }
}
