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
    var date = UIDatePicker()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var currentTimeOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTimeOutlet.text = "Уведомления отправляются с: \(UserSettings.userNotifFrom ?? " ")"
    }
    
//    func scheduleNotification(inSeconds seconds: TimeInterval, text: String, completion: (Bool) -> ()) {
//     
//        removeNotification(withIdentifiers:["notifStart"])
//        
//        let date = Date(timeIntervalSinceNow: seconds)
//        print (Date())
//        print(date)
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Текст"
//        content.sound = UNNotificationSound.default
//        
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.hour, .minute], from: date)
//        print(components)
//        
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
//        let request = UNNotificationRequest(identifier: "notifStart", content: content, trigger: trigger)
//        
//        let center = UNUserNotificationCenter.current()
//        center.add(request, withCompletionHandler: nil)
//    }
    
    func removeNotification(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            UserSettings.userNotifFrom = self.dateFormatter.string(from: self.datePickerOutlet.date)
        appDelegate?.startSendingNotifications()
            print(UserSettings.userNotifFrom!)
            self.currentTimeOutlet.text = "Уведомления отправляются с: \(UserSettings.userNotifFrom!)"
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
    }
    
    
}

