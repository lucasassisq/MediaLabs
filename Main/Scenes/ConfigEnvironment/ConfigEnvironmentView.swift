import UIKit
import Core

// MARK: - Class

final class ConfigEnvironmentView: UIView {


    let navBarView = AppNavBarView(navButtonStyle: .none,
                                   backgroundColor: Colors.marge.color,
                                   title: "Posterr App")
    

    let titleLabel = AppLabel(text: AppStrings.chooseUserTitle,
                              font: FontFamily.OpenSans.regular,
                              fontSize: 16,
                              alignment: .center,
                              textColor: Colors.luann.color)

    let tableView: IntrinsicTableView = {
        $0.separatorStyle = .none
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = Colors.nelson.color
        $0.showsVerticalScrollIndicator = false
        $0.estimatedRowHeight = 86.0
        $0.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        $0.register(ConfigEnvironmentCell.self,
                    forCellReuseIdentifier: ConfigEnvironmentCell.reuseIdentifier)
        return $0
    }(IntrinsicTableView())

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.nelson.color
        addComponents()
        callConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Protocol Extension

extension ConfigEnvironmentView: ViewProtocol {

    func addComponents() {
        addSubviews([navBarView,
                     titleLabel,
                     tableView], constraints: true)
    }

    func callConstraints() {
        setupNavBarConstraints()
        titleLabelConstraints()
        tableViewConstraints()
    }
}

// MARK: - Private Extension

private extension ConfigEnvironmentView {

    // MARK: - Private methods

    func setupNavBarConstraints() {
        navBarView.applyAnchors(ofType: [.top,
                                         .trailing,
                                         .leading], to: self)
    }

    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0)
        ])
        titleLabel.height(size: 30.0)
    }

    func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        ])
    }
}
