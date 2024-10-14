//
//  UserDefaultsManager.swift
//  BM Task 1
//
//  Created by Apple on 22/07/2024.
//
import Foundation

class UserDefaultsManager {
    //MARK: - Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }

    //MARK: - Properties
    private let def = UserDefaults.standard
    
    var isLoggedIn: Bool? {
        set {
            def.setValue(newValue, forKey: "isLoggedIn")
        }
        get {
            if def.object(forKey: "isLoggedIn") == nil {
                return nil
            }
            return def.bool(forKey: "isLoggedIn")
        }
    }
}
