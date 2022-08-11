import UIKit

// MARK: - Coordinator Protocol

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var parent: Coordinator? { get set }
    func start()
    func customBack(lastInstance: Bool)
}


// MARK: - Coordinator Extensions

public extension Coordinator {

    func start() {}

    func add(_ child: Coordinator) {
        children.append(child)
        child.parent = self
    }

    func remove(_ child: Coordinator) {
        children.removeAll { $0 === child }
    }

    func back() {
        navigationController.popViewController(animated: true)
    }

    func backWithoutAnimation() {
        navigationController.popViewController(animated: false)
    }

    func finish() {
        if let parent = parent {
            parent.remove(self)
            navigationController.popToRootViewController(animated: true)
        }
    }

    func customBack(lastInstance: Bool = false) {
        if let parent = parent {
            parent.customBack(lastInstance: lastInstance)
        }
    }

    func popToViewController<T>(withDestinationViewControllerType vcType: T.Type) {
        if let vc = T.self as? AnyClass {
            navigationController.popToViewController(ofClass: vc)
        }
    }

    func verifyIfViewControllerIsInStack<T: UIViewController>(_ viewController: T.Type) -> Bool {
        var exists = false
        navigationController.viewControllers.forEach({ controller in
            if(controller.isKind(of: viewController)) {
                exists = true
            }
        })
        return exists
    }
}
