import UIKit
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // MARK: - Add some method here to validate something if you want
        checkUsers()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

// MARK: - Extension

extension AppDelegate {

    // MARK: - Add your method here if you want

    private func checkUsers() {
        let users = Storage.fetchUsers()
        if users == nil || users?.count == 0 {
            let firstUserDate = Date()
            let secondUserDate = Date().add(value: -12, byAdding: .day)
            let thirdUserDate = Date().add(value: -2, byAdding: .day)
            let fourthUserDate = Date().add(value: -35, byAdding: .day)
            let fifthUserDate = Date().add(value: -20, byAdding: .day)

            let users = [User(username: "WalterWhite", dateJoined: firstUserDate.getStringDate(), posts: []),
                         User(username: "JessePinkman", dateJoined: secondUserDate.getStringDate(), posts: []),
                         User(username: "SkylerWhite", dateJoined: thirdUserDate.getStringDate(), posts: []),
                         User(username: "WhiteJr", dateJoined: fourthUserDate.getStringDate(), posts: []),
                         User(username: "HenrySchrader", dateJoined: fifthUserDate.getStringDate(), posts: [])]
            Storage.saveUsers(accounts: users)
        }
    }


}
