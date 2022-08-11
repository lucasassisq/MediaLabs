import UIKit

public extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true, lastInstance: Bool = false) {
        if(lastInstance) {
            let value = String(describing: ofClass.self)            
            guard let vc = viewControllers.last(where: {
                    guard let valueItem = String(describing: $0.self).components(separatedBy: ".").last?.components(separatedBy: ":").first else { return false }
                    if(valueItem.contains(value)) {
                        return true
                    } else {
                        return false
                    }
                }) else { return }
            popToViewController(vc, animated: animated)
        } else {
            for controller in viewControllers as Array {
                if controller.isKind(of: ofClass.self) {
                    popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
    
    func hasViewController(_ controller: UIViewController.Type) -> Bool {
        if let _ = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            return true
        }
        
        return false
    }
}
