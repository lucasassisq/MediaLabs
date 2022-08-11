import Core

// MARK: - Class

final class ConfigEnvironmentService: BaseService {

    func getCharacters(completion: @escaping(Result<[Characters], ResponseError>) -> Void) {
        let request = createRequest(path: "characters", method: .get)
        service.performRequest(route: request, completion: completion)
    }
}

struct Characters: Codable {

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
    }

    let charID: Int
    let name, birthday: String
    let occupation: [String]
    let img: String
    let status, nickname: String
    let appearance: [Int]
    let portrayed, category: String
}
