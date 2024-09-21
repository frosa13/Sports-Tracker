//
//  SceneDelegate.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let navVC = UINavigationController(rootViewController: SportsDashboard())
        
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
