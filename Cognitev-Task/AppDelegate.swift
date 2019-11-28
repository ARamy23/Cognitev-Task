//
//  AppDelegate.swift
//  Cognitev-Task
//
//  Created by Ahmed Ramy on 11/27/19.
//  Copyright © 2019 Ahmed Ramy. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let vc = AppStoryboard.Main.initialViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return true
    }
}

