import Core

// MARK: - Class

final class WeatherService: BaseService {

    func getWeather(completion: @escaping(Result<WeatherResponse, ResponseError>) -> Void) {
        let lat = 34.0194704
        let long = -118.491227
        let appId = Url.shared.appId
        let request = createRequest(path: "weather?lat=\(lat)&lon=\(long)&appid=\(appId)", method: .get)
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: - WeatherResponse

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds

struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord

struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main

struct Main: Codable {

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }

    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
}

// MARK: - Sys

struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather

struct Weather: Codable {

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    let id: Int
    let main, weatherDescription, icon: String
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
