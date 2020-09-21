//
//  AppDelegate.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    let defaults = UserDefaults.standard
    let dateFormatter = DateFormatter()
    let modalInternalVCDelegate = ModalIntervalVC()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.dateFormatter.dateFormat = "HH:mm"
        modalInternalVCDelegate.scheduleNotification(inSeconds: Double(UserSettings.userIntervalNotif ?? 60), text: "Не забудь выпить воды!") { (success) in
            if success {
                print("success")
            } else {
                print("failed")
            }
        }
        

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
        let targetLang = UserDefaults.standard.object(forKey: "selectedLanguage") as? String
        Bundle.setLanguage((targetLang != nil) ? targetLang! : "en")
        
    
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
        registerForPushNotifications()
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
    

    
    func registerForPushNotifications() {
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
        (granted, error) in
        print("Permission granted: \(granted)")

        guard granted else { return }
        self.getNotificationSettings()
        self.createNotification()
      }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        UIApplication.shared.registerForRemoteNotifications()
      }
    }
    
    public func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Не забудь выпить воды!"
        //Set the trigger of the notification -- here a timer.
        //Устанавливаем триггер на уведомления (в секундах)
        if UserSettings.userIntervalNotif == 0 {
            UserSettings.userIntervalNotif = 3600
        }
        print(UserSettings.userIntervalNotif!)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(UserSettings.userIntervalNotif!), repeats: true)
        
        

        //Set the request for the notification from the above
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        // UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
             UNUserNotificationCenter.current().add(request) { (error) in
                 if error != nil {
                     print("Add notification error: \(String(describing: error?.localizedDescription))")
                 }
             }
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            print("did recieve notif")
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound, .badge])
        }
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let tokenParts = deviceToken.map { data -> String in
        return String(format: "%02.2hhx", data)
      }
      
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }
}


