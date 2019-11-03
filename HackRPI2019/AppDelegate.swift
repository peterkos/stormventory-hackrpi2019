//
//  AppDelegate.swift
//  HackRPI2019
//
//  Created by Peter Kos on 11/2/19.
//  Copyright © 2019 RIT. All rights reserved.
//

import UIKit
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Intercept auth callback
        return Auth0.resumeAuth(url, options: options)
    }

}

