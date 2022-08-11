import UIKit

public extension UIStackView {
    
    func addSpace(height: CGFloat? = nil, width: CGFloat? = nil, backgroundColor: UIColor = .clear) {
        let spaceView = UIView()
        spaceView.backgroundColor = backgroundColor
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            spaceView.height(size: height)
        }
        if let width = width {
            spaceView.width(size: width)
        }
        addArrangedSubview(spaceView)
    }
    
    func addSpace(_ size: CGFloat) {
        switch self.axis {
        case .vertical:
            addSpace(height: size)
        case .horizontal:
            addSpace(width: size)
        default: break
        }
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
    
    func addBackgroundColor(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
