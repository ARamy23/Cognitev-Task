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
        let appIsInTestMode = CommandLine.arguments.count <= 1
        if appIsInTestMode {
            NetworkActivityLogger.shared.startLogging()
            NetworkActivityLogger.shared.level = .debug
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = AppStoryboard.Main.initialViewController()
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        return true
    }
}

