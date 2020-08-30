//
//  AppDelegate.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

//        if (UserSettings.userSex != nil) && (UserSettings.checkUserWeight != nil) && (UserSettings.userActivity != nil) {
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = mainStoryboard.instantiateViewController(identifier: "MainViewController")
//            let navigationController = UINavigationController(rootViewController: mainViewController)
//            self.window?.rootViewController = navigationController
//            self.window?.makeKeyAndVisible()
//        } else {
//            let firstStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let firstView = firstStoryboard.instantiateViewController(withIdentifier: "welcomeVC")
//            let navigationController = UINavigationController(rootViewController: firstView)
//            self.window?.rootViewController = navigationController
//            self.window?.makeKeyAndVisible()
//        }
        
    
        if UserDefaults.standard.bool(forKey: "SexSelected") && UserDefaults.standard.bool(forKey: "weightSet") && UserDefaults.standard.bool(forKey: "activitySet") && UserDefaults.standard.bool(forKey: "resultShowed") {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(identifier: "MainViewController")
            let navigationController = UINavigationController(rootViewController: mainViewController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        } else {
            let firstStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let firstView = firstStoryboard.instantiateViewController(withIdentifier: "welcomeVC")
            let navigationController = UINavigationController(rootViewController: firstView)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


