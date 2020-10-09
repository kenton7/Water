//
//  ToVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 19.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class ModalToVC: UIViewController, HalfModalPresentable {
    
    let dateFormatter = DateFormatter()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var timeLabelOutlet: UILabel!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabelOutlet.text = NSLocalizedString("NOTIFICATIONS_TO", comment: "to")
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        UserSettings.userNotifTo = dateFormatter.string(from: datePickerOutlet.date)
        appDelegate?.stopSendingNotifications()
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
