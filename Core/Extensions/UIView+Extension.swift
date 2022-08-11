import UIKit

// swiftlint:disable all
public extension UIView {
    
    // MARK: - Anchors extensions
    
    enum AnchorType {
        case top
        case bottom
        case leading
        case trailing
        case heigth
        case width
        case centerX
        case centerY
    }
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    func addSubview(_ subview: UIView, constraints: Bool) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = !constraints
    }
    
    func addSubviews(_ subviews: [UIView], constraints: Bool) {
        for subview in subviews {
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = !constraints
        }
    }
    
    func applyAnchors(ofType: [AnchorType], to referenceView: UIView) {
        
        if ofType.contains(.bottom) {
            self.bottomAnchor.constraint(equalTo: referenceView.bottomAnchor).isActive = true
        }
        
        if ofType.contains(.top) {
            self.topAnchor.constraint(equalTo: referenceView.topAnchor).isActive = true
        }
        
        if ofType.contains(.trailing) {
            self.trailingAnchor.constraint(equalTo: referenceView.trailingAnchor).isActive = true
        }
        
        if ofType.contains(.leading) {
            self.leadingAnchor.constraint(equalTo: referenceView.leadingAnchor).isActive = true
        }
        
        if ofType.contains(.heigth) {
            self.heightAnchor.constraint(equalTo: referenceView.heightAnchor).isActive = true
        }
        
        if ofType.contains(.width) {
            self.widthAnchor.constraint(equalTo: referenceView.widthAnchor).isActive = true
        }
        
        if ofType.contains(.centerX) {
            self.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor).isActive = true
        }
        if ofType.contains(.centerY) {
            self.centerYAnchor.constraint(equalTo: referenceView.centerYAnchor).isActive = true
        }
    }
    
    @discardableResult
    func height(size: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        constraint = heightAnchor.constraint(equalToConstant: size)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func height(min: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: min)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func width(size: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = widthAnchor.constraint(equalToConstant: size)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func width(min: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: min)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func centerX(to: UIView, padding: CGFloat? = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = centerXAnchor.constraint(equalTo: to.centerXAnchor, constant: padding ?? 0)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func centerY(to: UIView, padding: CGFloat? = nil) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: padding ?? 0)
        constraint.isActive = true
        return constraint
    }
    
    func center(to view: UIView) {
        self.applyAnchors(ofType: [.centerX, .centerY], to: view)
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        //        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        //        if let action = self.tapGestureRecognizerAction {
        //            action?()
        //        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func snapshotForCompletePage() -> UIImage? {
        let tmpFrame: CGRect = frame
        var fullSizeFrame: CGRect = frame
        fullSizeFrame.size.height = layer.bounds.height
        frame = fullSizeFrame
        UIGraphicsBeginImageContextWithOptions(fullSizeFrame.size, false, UIScreen.main.scale)
        let resizedContext = UIGraphicsGetCurrentContext()
        guard let context = resizedContext else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        frame = tmpFrame
        return image
    }
    
    func loadJson(from filename: String) -> Data? {
        guard
            let path =  Bundle(for: type(of: self)).path(forResource: filename, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        else { return nil }
        return data
    }
    
    func getModel<T>(model: T.Type, jsonName: String) -> T? where T: Decodable{
        let jsonDecoder = JSONDecoder()
        if let json = self.loadJson(from: jsonName),
           let data = try? jsonDecoder.decode(model, from: json) {
            return data
        } else {
            print("Decoding error \(String(describing: T.self))")
            return nil
        }
    }
    
}
