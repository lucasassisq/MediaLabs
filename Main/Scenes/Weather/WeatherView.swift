import UIKit
import Core

// MARK: - Class

final class WeatherView: UIView {

    let titleLabel = AppLabel(font: FontFamily.OpenSans.regular,
                              fontSize: 16,
                              alignment: .center,
                              textColor: Colors.nelson.color)

    let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    let temperatureLabel = AppLabel(font: FontFamily.OpenSans.regular,
                                    fontSize: 62,
                                    alignment: .center,
                                    textColor: Colors.nelson.color)

    let descriptionLabel = AppLabel(font: FontFamily.OpenSans.regular,
                                    fontSize: 16,
                                    alignment: .center,
                                    textColor: Colors.nelson.color)

    lazy var stackHorizontal: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 8.0
        $0.alignment = .leading
        $0.addArrangedSubview(lowLabel)
        $0.addArrangedSubview(highLabel)
        return $0
    }(UIStackView())

    let lowLabel = AppLabel(font: FontFamily.OpenSans.regular,
                            fontSize: 16,
                            alignment: .center,
                            textColor: Colors.nelson.color)

    let highLabel = AppLabel(font: FontFamily.OpenSans.regular,
                             fontSize: 16,
                             alignment: .center,
                             textColor: Colors.nelson.color)

    let windLabel = AppLabel(font: FontFamily.OpenSans.regular,
                             fontSize: 16,
                             alignment: .center,
                             textColor: Colors.nelson.color)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.luann.color
        addComponents()
        callConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension WeatherView {

    // MARK: - Internal methods

    func populate(response: WeatherResponse) {
        titleLabel.text = response.name
        temperatureLabel.text = "\(Int(response.main.temp))°"
        descriptionLabel.text = response.weather[0].weatherDescription.firstUppercased
        lowLabel.text = "\(AppStrings.lowTemp)\(Int(response.main.tempMin))°"
        highLabel.text = "\(AppStrings.highTemp)\(Int(response.main.tempMax))°"
        windLabel.text = "\(AppStrings.wind)\(response.wind.speed) (\(response.wind.deg))"
    }

    func loadImage(url: URL) {
        imageView.load(url: url)
    }

    // MARK: - Private methods

    private func addComponents() {
        addSubviews([titleLabel,
                    imageView,
                    temperatureLabel,
                    descriptionLabel,
                    stackHorizontal,
                    windLabel], constraints: true)
    }

    private func callConstraints() {
        setTitleLabelConstraints()
        setImageViewConstraints()
        setTemperatureLabelConstraints()
        setDescriptionLabelConstraints()
        setStackConstraints()
        setWindLabelConstraints()
    }

    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.centerX(to: self)
        ])
    }

    private func setImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            imageView.centerX(to: self),
            imageView.width(size: 180.0),
            imageView.height(size: 180.0)
        ])
    }

    private func setTemperatureLabelConstraints() {
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            temperatureLabel.centerX(to: self)
        ])
    }

    private func setDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8.0),
            descriptionLabel.centerX(to: self)
        ])
    }

    private func setStackConstraints() {
        NSLayoutConstraint.activate([
            stackHorizontal.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8.0),
            stackHorizontal.centerX(to: self),
            stackHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            stackHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])
    }

    private func setWindLabelConstraints() {
        NSLayoutConstraint.activate([
            windLabel.topAnchor.constraint(equalTo: stackHorizontal.bottomAnchor, constant: 8.0),
            windLabel.centerX(to: self)
        ])
    }
}
