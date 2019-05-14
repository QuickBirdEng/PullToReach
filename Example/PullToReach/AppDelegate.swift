//
//  AppDelegate.swift
//  PullToReach
//
//  Created by grafele on 04/25/2019.
//  Copyright (c) 2019 grafele. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Stored properties

    let window = UIWindow(frame: UIScreen.main.bounds)

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window.rootViewController = UINavigationController(rootViewController: TeamMembersViewController())
        window.makeKeyAndVisible()

        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().prefersLargeTitles = true

        return true
    }

}

