//
//  SceneDelegate.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 22.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
    }
}

