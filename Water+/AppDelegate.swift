//
//  AppDelegate.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()
    let defaults = UserDefaults.standard
    let dateFormatter = DateFormatter()
    let modalInternalVCDelegate = ModalIntervalVC()
    let modalFromVCDelegate = ModalFromVC()
    var currentTimeOnDeviceForStop = ""
    var currentTimeOnDevice = ""
    let date = Date()
    let gcmMessageIDKey = "gcm.message_id"
    var token = ""
    let sender = PushNotificationSender()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.dateFormatter.dateFormat = "HH:mm"
        let result = dateFormatter.string(from: date)
        currentTimeOnDevice = result
        
//        if #available(iOS 10.0, *) {
//          // For iOS 10 display notification (sent via APNS)
//          UNUserNotificationCenter.current().delegate = self
//
//          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//          UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: {_, _ in })
//        } else {
//          let settings: UIUserNotificationSettings =
//          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//          application.registerUserNotificationSettings(settings)
//        }
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()

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
        Bundle.setLanguage((targetLang != nil) ? targetLang! : "ru")
        
    
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
        startSendingNotifications()
        stopSendingNotifications()
        return true
    }
    
//    func application(_ application: UIApplication,
//                     continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        if userActivity.activityType == "com.ilyakuznetsov.WaterPlus" {
//            if let vc = window?.rootViewController as? MililetersViewController {
//                vc.addShortcut()
//            }
//        }
//        return true
//    }
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//                if userActivity.activityType == "addDrink.SiriShortcuts.addDrink" {
//                    if let vc = window?.rootViewController as? SiriShortcutsVC {
//                        if let labelDrink = vc.labelOutlet {
//                            labelDrink.text = "Drink Water"
//                        }
//                    }
//                }
//        let vc = AddDrinksViewController()
//        navigationController.pushViewController(vc, animated: false)
//      return true
//    }

    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    /*
     //        typealias TimeOfDay = (hour: Int, minute: Int, second: Int)
     //        var calendar = Calendar.autoupdatingCurrent
     //        calendar.timeZone = .current
     //        let strings: [String] = [currentTimeOnDevice, UserSettings.userNotifTo]
     //        print(strings)
     //        let timesOfDay: [TimeOfDay] = strings.map({ (string) -> TimeOfDay in
     //            let components = calendar.dateComponents([.hour, .minute, .second], from: dateFormatter.date(from: string)!)
     //            return (hour: components.hour!, minute: components.minute!, second: components.second!)
     //        })
     //        print(timesOfDay)
             
     //        if timesOfDay[0] >= timesOfDay[1] {
     //            print("noitifcations turned off")
     //            DispatchQueue.main.async {
     //                UIApplication.shared.unregisterForRemoteNotifications()
     //            }
     //        } else {
     //            return
     //        }*/
    
    func registerForPushNotifications() {
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
        (granted, error) in
        print("Permission granted: \(granted)")

        guard granted else { return }
        self.getNotificationSettings()
        self.createNotification()
        self.startSendingNotifications()
        self.stopSendingNotifications()
      }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    public func createNotification() {
        //stopSendingNotifications()
        //startSendingNotifications()
        let content = UNMutableNotificationContent()
        content.title = "Не забудь выпить воды!"
        //Устанавливаем триггер на уведомления (в секундах)
        if UserSettings.userIntervalNotif == 0 {
            UserSettings.userIntervalNotif = 3600
        }
        print(UserSettings.userIntervalNotif!)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(UserSettings.userIntervalNotif!), repeats: true)
        
        //Создаем реквест на уведомление
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
             UNUserNotificationCenter.current().add(request) { (error) in
                 if error != nil {
                     print("Add notification error: \(String(describing: error?.localizedDescription))")
                 }
             }
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            _ = response.notification.request.content.userInfo
                    completionHandler()
            print("did recieve notif")
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            startSendingNotifications()
            stopSendingNotifications()
            _ = notification.request.content.userInfo
                    
            completionHandler([.alert, .sound, .badge])
        }
    }
    
    func startSendingNotifications() {
        typealias TimeOfDay = (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = Date()
        let result = dateFormatter.string(from: date)
        currentTimeOnDevice = result
        print(currentTimeOnDevice)
        var calendar = Calendar.current
        calendar.timeZone = .current
        let strings: [String] = [UserSettings.userNotifFrom ?? currentTimeOnDevice, currentTimeOnDevice]
        let timesOfDay: [TimeOfDay] = strings.map({ (string) -> TimeOfDay in
            let components = calendar.dateComponents([.year, .month, .day,.hour, .minute, .second], from: dateFormatter.date(from: string)!)
            return (year: components.year!, month: components.month!, day: components.day!, hour: components.hour!, minute: components.minute!, second: components.second!)
        })
        print(timesOfDay)
        
        if timesOfDay[0] > timesOfDay[1] {
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            print("turned off START notif")
        } else if timesOfDay[0] == timesOfDay[1] {
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            print("turn off START notif")
        } else {
            createNotification()
            sender.sendPushNotification(to: token, priority: "high", title: "sfs", body: "svsd")
            
            print("turned on START notif")
            //return
        }
    }
    
    func stopSendingNotifications() {
        
        typealias TimeOfDay = (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = Date()
        let result = dateFormatter.string(from: date)
        currentTimeOnDeviceForStop = result
        print(currentTimeOnDeviceForStop)
        //print(UserSettings.userNotifTo)
        var calendar = Calendar.current
        calendar.timeZone = .current
        let strings: [String] = [UserSettings.userNotifTo ?? currentTimeOnDeviceForStop, currentTimeOnDeviceForStop]
        let timesOfDay: [TimeOfDay] = strings.map({ (string) -> TimeOfDay in
            let components = calendar.dateComponents([.year, .month, .day,.hour, .minute, .second], from: dateFormatter.date(from: string)!)
            return (year: components.year!, month: components.month!, day: components.day!, hour: components.hour!, minute: components.minute!, second: components.second!)
        })
        print(timesOfDay)
        
        if UserSettings.userNotifFrom ?? currentTimeOnDevice >= currentTimeOnDevice && UserSettings.userNotifTo ?? currentTimeOnDevice >= currentTimeOnDevice {
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        } else {
            createNotification()
        }
        
        if timesOfDay[0] > timesOfDay[1] {
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            print("turned off STOP notif")
        } else if timesOfDay[0] == timesOfDay[1] {
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            print("turn off STOP notif")
        } else {
            createNotification()
            print("turned on STOP notif")
            //return
        }
    }
}

//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//      print("Firebase registration token: \(fcmToken)")
//        token = fcmToken
//
//      let dataDict:[String: String] = ["token": fcmToken]
//      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//      // TODO: If necessary send token to application server.
//      // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
    
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("message Data", remoteMessage.appData)
//    }
extension AppDelegate {
         func registerForPushNotifications(application: UIApplication) {
             if #available(iOS 10.0, *) {
                    // For iOS 10 display notification (sent via APNS)
                     UNUserNotificationCenter.current().delegate = self
                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
                    // For iOS 10 data message (sent via FCM
                   Messaging.messaging().delegate = self
               } else {
                   let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
            application.registerForRemoteNotifications()
        }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let tokenParts = deviceToken.map { data -> String in
        return String(format: "%02.2hhx", data)
      }
      
      let token = tokenParts.joined()
      print("Device Token: \(token)")
        
        let tokenFirebase = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
                let savedAPNSToken = UserDefaults.standard.object(forKey: "savedAPNSToken") as? String
                if savedAPNSToken != tokenFirebase {
                    UserDefaults.standard.set(tokenFirebase, forKey: "savedAPNSToken")
                    UserDefaults.standard.synchronize()
                    Messaging.messaging().apnsToken = deviceToken
                }
    }
    
    

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
        sender.sendPushNotification(to: fcmToken, priority: "high", title: "dfgdfgdfg", body: "fgdfgdf")
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}


