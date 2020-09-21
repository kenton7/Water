//
//  ModalVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 19.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import UserNotifications

class ModalFromVC: UIViewController, HalfModalPresentable {
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var currentTimeOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTimeOutlet.text = "Уведомления отправляются с: \(UserSettings.userNotifFrom ?? " ")"
    }
    
    func scheduleNotification(inSeconds seconds: TimeInterval, text: String, completion: (Bool) -> ()) {
     
        removeNotification(withIdentifiers:["Bear"])
        
        let date = Date(timeIntervalSinceNow: seconds)
        print (Date())
        print(date)
        
        let content = UNMutableNotificationContent()
        content.title = "Текст"
        content.body = "Текст"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "Bear", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    func removeNotification(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        DispatchQueue.main.async {
            //let timeNotifFrom: Date = self.datePickerOutlet.date
            self.dateFormatter.dateFormat = "HH:mm"
            UserSettings.userNotifFrom = self.dateFormatter.string(from: self.datePickerOutlet.date)
//            let content = UNMutableNotificationContent()
//            content.title = "Не забудь выпить воды!"
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(UserSettings.userNotifFrom)! * 3600, repeats: true)
//            let request = UNNotificationRequest(identifier: "notificationStart", content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            self.currentTimeOutlet.text = "Уведомления отправляются с: \(UserSettings.userNotifFrom!)"
        }
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

