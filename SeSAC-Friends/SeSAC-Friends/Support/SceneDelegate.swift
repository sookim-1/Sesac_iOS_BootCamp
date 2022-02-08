//
//  SceneDelegate.swift
//  SeSAC-Friends
//
//  Created by sookim on 2022/01/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "firstLaunchKey")
        firstLaunch.isFirstLaunch ? (window?.rootViewController = OnboardingVC()) : (window?.rootViewController = UINavigationController(rootViewController: TabBarVC()))
        window?.makeKeyAndVisible()
    }

}

