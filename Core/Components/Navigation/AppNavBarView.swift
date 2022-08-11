import UIKit

// MARK: - Class

public class AppNavBarView: UIView {        
    
    // MARK: - Private variables

    private let containerView = UIView()
    
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private var _buttonType: AppNavBarType = .back
    
    private var rightButtonContainsText: Bool {
        switch buttonType {
        default:
            return false
        }
    }
    
    // MARK: - Public variables
    
    public let title = AppLabel(font: FontFamily.OpenSans.bold,
                                fontSize: 18.0,
                                alignment: .center,
                                textColor: Colors.luann.color,
                                numberOfLines: 1,
                                adjustsFontToFitWidth: true)
    
    public let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    public let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = Colors.barney.color
        return button
    }()
        
    public var buttonType: AppNavBarType { return _buttonType }
    
    
    // MARK: - Initializers
    
    public init(navButtonStyle: AppNavBarType = .back,
                backgroundColor color: UIColor = .clear,
                title: String = "") {
        
        super.init(frame: .zero)
        self.title.text = title
        backgroundColor = Colors.twitter.color
        containerView.backgroundColor = .white
        addComponents()
        createConstraints()
        refreshImages(navButtonStyle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        rightButton.imageView?.layer.cornerRadius = rightButton.bounds.height/2.0
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
    }
}

extension AppNavBarView {
    
    // MARK: - Private methods
    
    private func addComponents() {
        addSubview(containerView, constraints: true)
        containerView.addSubview(containerStack, constraints: true)

        containerStack.addArrangedSubview(leftButton)
        containerStack.addArrangedSubview(title)
        containerStack.addArrangedSubview(rightButton)

        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 50.0).isActive = true

        containerView.applyAnchors(ofType: [.trailing, .bottom, .leading], to: self)
        containerStack.applyAnchors(ofType: [.top, .bottom], to: containerView)
        containerStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.0).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16.0).isActive = true
    }
    
    private func createConstraints() {
        leftButton.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        rightButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        leftButton.bottomAnchor.constraint(equalTo: containerStack.bottomAnchor, constant: -12.0).isActive = true
    }
    
    private func setupLeftButton(image: UIImage) {
        leftButton.contentHorizontalAlignment = .left
        leftButton.setImage(image, for: .normal)
        leftButton.setTitle(nil, for: .normal)
    }
    
    private func setupRightButton(image: UIImage) {
        rightButton.contentHorizontalAlignment = .right
        rightButton.setImage(image, for: .normal)
        rightButton.setTitle(nil, for: .normal)
    }

    // MARK: - Public methods
    
    public func refreshImages(_ type: AppNavBarType) {
        _buttonType = type
        
        leftButton.isHidden = false
        rightButton.isHidden = false

        switch type {

        case .back, .backAndTitle:
            setupLeftButton(image: Assets.iconBack.image)

        case .backAndTextAndRightButton:
            setupLeftButton(image: Assets.iconBackRounded.image)

        case .none, .title:
            leftButton.isHidden = true
            rightButton.isHidden = true

        case .titleAndRight:
            setupLeftButton(image: Assets.iconBack.image)

        }
    }

    public func updateRightButton(url: URL) {
        UIImageView().downloaded(from: url, completion: { [weak self] imgResult in
            guard let self = self else { return }
            self.rightButton.setImage(imgResult, for: .normal)
        })
    }
}
