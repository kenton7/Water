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
    @IBOutlet weak var timeLabelOutlet: UILabel!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabelOutlet.text = "Уведомления отправляются до: \(UserSettings.userNotifTo ?? "")"
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.dateFormatter.dateFormat = "HH:mm"
            UserSettings.userNotifTo = self.dateFormatter.string(from: self.datePickerOutlet.date)
            self.timeLabelOutlet.text = "Уведомления отправляются до: \(UserSettings.userNotifTo!)"
        }
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
