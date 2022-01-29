//
//  SceneDelegate.swift
//  EightBall
//
//  Created by Ostap Tyvonovych on 27.01.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
            
            self.window = window
        }
    }
}

