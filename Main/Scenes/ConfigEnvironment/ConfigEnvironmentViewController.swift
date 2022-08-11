import UIKit
import Core

// MARK: - Class

final class ConfigEnvironmentViewController: ViewController<ConfigEnvironmentView> {

    // MARK: - Private variable

    let viewModel: ConfigEnvironmentViewModel

    // MARK: - Initializer

    init(viewModel: ConfigEnvironmentViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAccounts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if viewModel.characters.count > 5 {
            fetchUsers(characters: viewModel.characters)
        }
    }
}

// MARK: - Extension class

extension ConfigEnvironmentViewController {

    func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }

    func fetchAccounts() {
        viewModel.fetchImages { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                self.viewModel.characters = characters
                self.fetchUsers(characters: characters)
            case .failure(_):
                self.fetchUsers(characters: [])
            }
        }
    }

    func fetchUsers(characters: [Characters]) {
        guard var users = Storage.fetchUsers() else { return }
        if(characters.count > 4 && users.count > 4) {
            users[0].imgUrl = characters[0].img
            users[1].imgUrl = characters[1].img
            users[2].imgUrl = characters[2].img
            users[3].imgUrl = characters[3].img
            users[4].imgUrl = characters[4].img
            Storage.saveUsers(accounts: users)
        }
        viewModel.users = users
        setupTableView()
        customView.tableView.reloadData()
    }
}

// MARK: - Extensions TableView

extension ConfigEnvironmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.createCells(tableView: tableView)
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.usersCell[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        print(user)
        // MARK: - put here your code to go to next screen

    }
}
