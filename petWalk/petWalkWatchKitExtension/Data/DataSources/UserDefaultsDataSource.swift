import Foundation

protocol UserDefaultDataSource {
    func get<T>(forKey: String) -> T?
    func set<T>(value: T, forKey: String)
}

class UserDefaultDataSourceImplementation: UserDefaultDataSource {
    private let userDefault = UserDefaults.standard
    
    func get<T>(forKey: String) -> T? {
        return userDefault.object(forKey: forKey) as? T
    }
    
    func set<T>(value: T, forKey: String) {
        self.userDefault.set(value, forKey: forKey)
    }
}
