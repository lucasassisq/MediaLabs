import Foundation

// MARK: - UserDefaults extension

public extension UserDefaults {
    static var shared: UserDefaults {
        if let suit = UserDefaults(suiteName: "com.posterr") {
            return suit
        }
        return UserDefaults.shared
    }
    
    /**
     - How to use: UserDefaults.shared.makeClearedInstance()
     */
    func makeClearedInstance() {
        removePersistentDomain(forName: "com.posterr")
    }
    
    func setToken(_ token: String) {
        setValue(token, forKey: "token")
        synchronize()
    }
    
    func getToken() -> String {
        return value(forKey: "token") as? String ?? ""
    }
}
