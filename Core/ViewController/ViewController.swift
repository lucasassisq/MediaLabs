import UIKit
import RxSwift
import RxCocoa
import RxGesture

// swiftlint:disable force_cast
open class ViewController<View: UIView>: UIViewController {

    public typealias ActionVoid = () -> Void
    
    public var customView: View {
        return view as! View
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = View()
    }
    
    public func setupRxButton(button: UIButton, action: @escaping (ActionVoid)) {
        button
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                guard self != nil else { return }
                action()                
            }).disposed(by: disposeBag)
    }
    
    public func setupRxField(textField: UITextField, action: @escaping(ActionVoid), event: UIControl.Event = .editingChanged) {
        textField.rx
            .controlEvent([event])
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard self != nil else { return }
                action()
            }).disposed(by: disposeBag)
    }
    
    public func setupRxViewGesture(view: UIView, action: @escaping(ActionVoid), event: UIGestureRecognizer.State = .recognized) {
        view.rx
            .tapGesture()
            .when(event)
            .subscribe(onNext: { [weak self] _ in
                guard self != nil else { return }
                action()
            }).disposed(by: disposeBag)
    }
    
    func dismissKeyboard() {
        customView.endEditing(true)
    }
}
