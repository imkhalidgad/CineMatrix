//
//  AppDelegate.swift
//  BM Task 1
//
//  Created by Mahmoud Elsharkawy on 19/07/2024.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        setRootView()
        return true
    }
    
    
    func setRootView() {
        if let isLoggedIn = UserDefaultsManager.shared().isLoggedIn {
            if isLoggedIn {
                switchToHomeState()
            } else {
                switchToAuthState()
            }
        }
    }
    
    func switchToAuthState() {
        let sb = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let logVC = sb.instantiateViewController(withIdentifier: VCs.login) as! LoginVC
        UserDefaultsManager.shared().isLoggedIn = false
        window?.rootViewController = logVC
    }
    
    func switchToHomeState() {
        let sb = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let mediaVC = sb.instantiateViewController(withIdentifier: VCs.mediaList) as! MediaVC
        window?.rootViewController = mediaVC
    }
    
}
