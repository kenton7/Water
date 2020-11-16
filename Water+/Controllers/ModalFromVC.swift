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
        _ = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        currentTimeOutlet.text = NSLocalizedString("NOTIFICATIONS_FROM", comment: "from")
    }
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            UserSettings.userNotifFrom = self.dateFormatter.string(from: self.datePickerOutlet.date)
        appDelegate?.startSendingNotifications()
            print(UserSettings.userNotifFrom!)
            self.currentTimeOutlet.text = NSLocalizedString("NOTIFICATIONS_FROM", comment: "from")
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

