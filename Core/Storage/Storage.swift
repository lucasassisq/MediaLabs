import Foundation

// MARK: - Class

public final class Storage {

    // MARK: - Public variables

    public typealias ActionVoid = () -> Void

    // MARK: - Private variables

    private static let defaults = UserDefaults.shared
    private static let defaultsKeyObjectOne = "defaultsKeyOne"
    private static let defaultsKeyObjectTwo = "defaultsKeyTwo"
    private static let defaultsKeyString = "defaultsKeyString"
}

extension Storage {

    // MARK: - Public methods

    public static func saveDefaultString(_ defaultsKeyString: String) {
        defaults.setValue(saveDefaultString, forKey: self.defaultsKeyString)
    }

    public static func getDefaultString() -> String {
        if let defaultString = defaults.string(forKey: defaultsKeyString) {
            return defaultString
        } else {
            return ""
        }
    }

    public static func saveUser(account: User) {

        guard
            var accounts = fetchUsers()
        else {
            let accounts = [account]
            saveUsers(accounts: accounts)
            return
        }

        if !accounts.contains(account) {
            accounts.append(account)
            saveUsers(accounts: accounts)
        } else {
            update(account: account)
        }
    }

    public static func saveUsers(accounts: [User]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(accounts)
            defaults.set(data, forKey: defaultsKeyObjectOne)
            defaults.synchronize()
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }

    public static func fetchUsers() -> [User]? {
        if let data = defaults.data(forKey: defaultsKeyObjectOne) {

            do {
                let decoder = JSONDecoder()
                let accounts = try decoder.decode([User].self, from: data)
                return accounts
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }

        return nil
    }

    public static func savePost(post: Post) {

        guard
            var posts = fetchPosts()
        else {
            let posts = [post]
            savePosts(posts: posts)
            return
        }

        if !posts.contains(post) {
            posts.append(post)
            savePosts(posts: posts)
        } else {
            update(post: post)
        }
    }

    public static func savePosts(posts: [Post]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(posts)
            defaults.set(data, forKey: defaultsKeyObjectTwo)
            defaults.synchronize()
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }


    public static func fetchPosts() -> [Post]? {
        if let data = defaults.data(forKey: defaultsKeyObjectTwo) {

            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                return posts.sorted(by: { $0.datePost > $1.datePost })
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }

        return nil
    }

    public static func fetchPostForId(postId: Double) -> Post? {
        if let data = defaults.data(forKey: defaultsKeyObjectTwo) {

            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                return posts.first(where: { $0.id == postId })
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }

        return nil
    }

    public static func fetchDifferentPosts(username: String) -> [Post]? {
        if let data = defaults.data(forKey: defaultsKeyObjectTwo) {

            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                return posts.filter({ ($0.typePost == .post || $0.typePost == .retweet || $0.typePost == .quote) && $0.ownerPost != username})
                    .sorted(by: { $0.datePost > $1.datePost})
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }

        return nil
    }

    public static func fetchFeedPosts() -> [Post]? {
        if let data = defaults.data(forKey: defaultsKeyObjectTwo) {

            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                return posts.filter({ ($0.typePost == .post || $0.typePost == .retweet || $0.typePost == .quote)})
                    .sorted(by: { $0.datePost > $1.datePost})
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }

        return nil
    }

    public static func fetchAccount(username: String) -> User? {
        guard
            let accounts = fetchUsers()
        else {
            return nil
        }

        let accountSession = accounts.first(where: { $0.username == username })

        return accountSession
    }

    public static func update(account: User) {
        guard
            var accounts = fetchUsers()
        else {
            return
        }

        if let index = accounts.firstIndex(of: account) {
            accounts[index] = account
            saveUsers(accounts: accounts)
        }
    }

    public static func update(post: Post) {
        guard
            var posts = fetchPosts()
        else {
            return
        }

        if let index = posts.firstIndex(of: post) {
            posts[index] = post
            savePosts(posts: posts)
        }
    }


    public static func remove(account: User, callBack: ActionVoid) {
        guard
            var accounts = fetchUsers()
        else {
            return
        }

        if let index = accounts.firstIndex(of: account) {
            accounts.remove(at: index)
            saveUsers(accounts: accounts)
        }
        callBack()
    }

    public static func removeAll() {
        saveUsers(accounts: [])
    }
}

// MARK: - Struct User

public struct User: Codable {
    public var username: String
    public var dateJoined: String
    public var posts: [Post]
    public var imgUrl: String
    public var baseImg: String

    public init(username: String, dateJoined: String, posts: [Post], imgUrl: String = "", baseImg: String = "") {
        self.username = username
        self.dateJoined = dateJoined
        self.posts = posts
        self.imgUrl = imgUrl
        self.baseImg = baseImg
    }

    public func getPosts() -> Int {
        return posts.filter({$0.typePost == .post || $0.typePost == .quote || $0.typePost == .retweet }).count
    }

    public func getOnlyPosts() -> Int {
        return posts.filter({$0.typePost == .post }).count
    }

    public func getOnlyRetweets() -> Int {
        return posts.filter({$0.typePost == .retweet }).count
    }

    public func getOnlyQuotes() -> Int {
        return posts.filter({$0.typePost == .quote }).count
    }

    public func getOnlyComments() -> Int {
        return posts.filter({$0.typePost == .comment && $0.ownerPost == username }).count
    }

    public func canPost() -> Bool {
        if posts.count < 5 {
            return true
        }

        // Users are not allowed to post more than 5 posts in one day (including reposts and quote posts)

        return posts.filter({ $0.typePost != .comment && $0.datePost.isAfterDate(Date().add(value: -1, byAdding: .day))}).count < 5
    }
}

// MARK: - Post class - Need to be class, because struct is only value-types.

public class Post: Codable {

    public var contentText: String
    public var datePost: Date
    public var ownerPost: String
    public var typePost: TypePost
    public var parentPost: Double
    public var commentPosts: [Double]?
    public var id: Double

    public init (contentText: String, datePost: Date, ownerPost: String, typePost: TypePost, commentPosts: [Double]?, parentPost: Double) {
        self.contentText = contentText
        self.datePost = datePost
        self.ownerPost = ownerPost
        self.typePost = typePost
        self.commentPosts = commentPosts
        self.parentPost = parentPost
        self.id = Date().timeIntervalSince1970
    }

    public func getCommentQuantity() -> Int {
        guard let commentPosts = commentPosts else {
            return 0
        }

        return commentPosts.count
    }
}

public enum TypePost: Equatable, Codable {
    case post
    case comment
    case quote
    case retweet
}

extension User: Equatable {
    public static func==(lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
}


extension Post: Equatable {
    public static func==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
