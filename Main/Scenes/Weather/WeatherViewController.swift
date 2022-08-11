import UIKit
import Core

// MARK: - Class

final class WeatherViewController: ViewController<WeatherView> {

    // MARK: - Private variable

    let viewModel: WeatherViewModel

    // MARK: - Initializer

    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }
}

// MARK: - Extension

extension WeatherViewController {

    // MARK: - Private methods

    private func fetchWeather() {
        viewModel.getWeather { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.customView.populate(response: response)
                self.loadImage(id: response.weather[0].id)
            case .failure(let error):
                print("something wrong happened\(error)")
            }
        }
    }

    private func loadImage(id: Int) {
        guard let idImage = WeatherIcon.init().weatherIcon[id] else { return }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(idImage)@4x.png") else { return }
        customView.loadImage(url: url)
    }
}
