import Core
import UIKit

// MARK: - Class

final class ConfigEnvironmentViewModel: ViewModel {

    // MARK: - Private variables

    private let coordinator: MainCoordinator
    private let service = ConfigEnvironmentService(service: ServiceManager())

    // MARK: - Internal variables

    var users = [User]()
    var characters = [Characters]()
    var usersCell = [ConfigEnvironmentCell]()

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(coordinator: coordinator)
    }
}

// MARK: - Extension

extension ConfigEnvironmentViewModel {

    // MARK: - Internal methods

    func createCells (tableView: UITableView) {
        usersCell.removeAll()
        users.forEach { item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConfigEnvironmentCell.reuseIdentifier) as? ConfigEnvironmentCell else {
                return
            }
            cell.populate(user: item)
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            cell.layoutSubviews()
            usersCell.append(cell)
        }
    }

    func fetchImages(completion: @escaping(Result<[Characters], ResponseError>) -> Void) {
        service.getCharacters(completion: completion)
    }
    
}
