//
//  AppDelegate.swift
//  Interective Learning App
//
//  Created by Prefect on 10.09.2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        StageCoordinator(window).start()
        IQKeyboardManager.shared.enable = true
        return true
    }
}
