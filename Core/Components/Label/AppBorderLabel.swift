import UIKit

// MARK: - Class

public enum AppType: Equatable {
    
    case centerAndDefaultColor
    
    /** _ _ left */
    case leftAndChangedColor
    
    /** _ _ left */
    case leftAndDefaultColor
    
    /** _ _ left */
    case leftAndDefaultColorOption
}

public class AppBorderLabel: UILabel {
    
    // MARK: - Public variables
    
    override public var isEnabled: Bool {
        didSet {
            updateLayout()
        }
    }
    public lazy var textLabel = AppLabel(fontSize: 16,
                                         alignment: .center,
                                         textColor: Colors.luann.color,
                                         numberOfLines: 1,
                                         adjustsFontToFitWidth: true)

    // MARK: - Internal variables

    public lazy var contentView: UIView = {
        $0.backgroundColor = Colors.nelson.color
        $0.layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0.9058823529, blue: 0.9490196078, alpha: 1)
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 20.0
        return $0
    }(UIView())

    // MARK: - Initializers

    public init(title: String? = nil,
                accessibilityLabel: String? = nil,
                style: AppType? = .centerAndDefaultColor) {
        super.init(frame: .zero)
        textLabel.text = title

        if let accessibilityLabel = accessibilityLabel {
            textLabel.accessibilityLabel = accessibilityLabel
        } else {
            textLabel.accessibilityLabel = title
        }

        if let style = style {
            if style == .leftAndChangedColor {
                self.textLabel.isEnabled = false
                updateLeftConstraints()
                updateColor()
            } else if style == .leftAndDefaultColor {
                updateLeftConstraints()
            } else if style == .leftAndDefaultColorOption {
                updateLeftConstraintsOption()
            }
        }

        contentView.height(size: 55)
        addComponents()
        setupViews()
        setupViewsConstraint()
    }

    public required init?(coder: NSCoder) {
        fatalError("error not implemented yet")
    }
}

// MARK: - Extension

public extension AppBorderLabel {

    // MARK: - Internal Methods

    func updateLayout() {
        textLabel.textColor = isEnabled ? Colors.luann.color : Colors.barney.color
    }

    func updateLeftConstraints() {
        DispatchQueue.main.async {
            self.setupTextToLeft()
            self.textLabel.textAlignment = .left
        }
    }

    func updateLeftConstraintsOption() {
        DispatchQueue.main.async {
            self.setupTextToLeftOption()
            self.textLabel.textAlignment = .left
        }
    }

    func updateColor() {
        self.contentView.layer.borderColor = Colors.montgomery.color.cgColor
        self.contentView.backgroundColor = Colors.ned.color
        self.textLabel.textColor = Colors.milhouse.color
    }

    func setupTextToLeft() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0)
        ])
    }

    func setupTextToLeftOption() {
        NSLayoutConstraint.activate([
            self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0)
        ])
    }

    // MARK: - Private methods

    private func addComponents() {
        addSubview(contentView, constraints: true)
        addSubview(textLabel, constraints: true)
    }

    private func setupViews() {
        self.isUserInteractionEnabled = true
        self.textLabel.isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = true
    }

    private func setupViewsConstraint() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.centerX(to: self),
            textLabel.centerY(to: self)
        ])
    }
}
