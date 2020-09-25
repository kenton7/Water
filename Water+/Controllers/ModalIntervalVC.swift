//
//  IntervalVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 19.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class ModalIntervalVC: UIViewController {
    
    let dateFormatter = DateFormatter()
    let intervalModelDelegate = IntervalModel()
    var timeInSeconds: Int?
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var datePickerOutlet: UIPickerView!
    @IBOutlet weak var timeLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerOutlet.dataSource = self
        datePickerOutlet.delegate = self
        timeLabelOutlet.text = "Уведомления отправляются с периодичностью в \(UserSettings.userIntervalNotif) минут"
    }
    
    public func scheduleNotification(inSeconds seconds: TimeInterval, text: String, completion: (Bool) -> ()) {
     
        removeNotification(withIdentifiers:["Notif"])
        
        let date = Date(timeIntervalSinceNow: seconds)
        print (Date())
        print(date)
        
        let content = UNMutableNotificationContent()
        content.title = "Test"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "Notif", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    public func removeNotification(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
extension ModalIntervalVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervalModelDelegate.interval.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervalModelDelegate.interval[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch intervalModelDelegate.interval[row] {
        case "15 минут":
            timeInSeconds = 900
            UserSettings.userIntervalNotif = timeInSeconds!
            print(UserSettings.userIntervalNotif!)
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 15 минут"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "30 минут":
            timeInSeconds = 1800
            UserSettings.userIntervalNotif = timeInSeconds! 
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 30 минут"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "1 час":
            timeInSeconds = 3600
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 1 час"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "1 час и 30 минут":
            timeInSeconds = 4680
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 1 час и 30 минут"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "2 часа":
            timeInSeconds = 7200
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 2 часа"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "2 часа и 30 минут":
            timeInSeconds = 8280
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 2 часа и 30 минут"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
            //}
            appDelegate?.createNotification()
        case "3 часа":
            timeInSeconds = 10800
            UserSettings.userIntervalNotif = timeInSeconds!
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 3 часа"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "4 часа":
            timeInSeconds = 14400
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 4 часа"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "5 часов":
            timeInSeconds = 18000
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 5 часов"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        case "6 часов":
            timeInSeconds = 21600
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 6 часов"
            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
                if success {
                    print("success")
                } else {
                    print("failed")
                }
            }
            appDelegate?.createNotification()
        case "7 часов":
            timeInSeconds = 25200
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = "Уведомления отправляются с периодичностью в 7 часов"
//            scheduleNotification(inSeconds: Double(timeInSeconds!), text: "Не забудь выпить воды") { (success) in
//                if success {
//                    print("success")
//                } else {
//                    print("failed")
//                }
//            }
            appDelegate?.createNotification()
        default:
            break
        }
    }
}
