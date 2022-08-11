import UIKit
import RxSwift

// MARK: - Fileprivate variables

fileprivate var ak_MyDisposeBag: UInt8 = 0

// MARK: - UIViewController extensions

public extension UIViewController {
    
    var disposeBag: DisposeBag {
        get {
            if let obj = objc_getAssociatedObject(self, &ak_MyDisposeBag) as? DisposeBag {
                return obj
            }
            let obj = DisposeBag()
            objc_setAssociatedObject(self, &ak_MyDisposeBag, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            return obj
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ak_MyDisposeBag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
