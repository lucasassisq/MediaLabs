import UIKit

// MARK: - Class

public protocol ViewProtocol: AnyObject {
    func addComponents()
    func callConstraints()
}

open class View: UIView {

    // MARK: - Public variables

    public var navBarView = AppNavBarView(navButtonStyle: .back,
                                          backgroundColor: Colors.marge.color)

    public var scrollView = UIScrollView()

    public init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addComponents()
        setupNavBarConstraints()
        setupConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

public extension View {

    // MARK: - Public methods

    func configurateNavBar(title: String,
                           backgroundColor: UIColor = Colors.marge.color,
                           style: AppNavBarType = .back) {

        navBarView.title.text = title
        navBarView.backgroundColor = backgroundColor
        navBarView.refreshImages(style)
    }

    // MARK: - Private methods

    fileprivate func addComponents() {
        addSubviews([navBarView,
                     scrollView], constraints: true)
    }

    fileprivate func setupConstraints() {
        scrollView.applyAnchors(ofType: [.leading,
                                         .trailing,
                                         .bottom], to: self)
        scrollView.topAnchor.constraint(equalTo: navBarView.bottomAnchor).isActive = true
    }

    fileprivate func setupNavBarConstraints() {
        navBarView.applyAnchors(ofType: [.top,
                                         .trailing,
                                         .leading], to: self)
    }
}
