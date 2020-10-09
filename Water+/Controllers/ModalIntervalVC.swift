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
        switch UserSettings.userIntervalNotif {
        case 900:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_FIFTEEN", comment: "15")
        case 1800:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_THIRTY", comment: "30")
        case 3600:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_ONE_HOUR", comment: "30")
        case 4680:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_ONE_HOUR_AND_THIRTY", comment: "1:30")
        case 7200:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_TWO_HOURS", comment: "2")
        case 8280:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_TWO_HOURS_AND_THIRTY", comment: "2:30")
        case 10800:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_THREE_HOURS", comment: "3")
        case 14400:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_FOUR_HOURS", comment: "4")
        case 18000:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_FIVE_HOURS", comment: "5")
        case 21600:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_SIX_HOURS", comment: "6")
        case 25200:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_SEVEN_HOURS", comment: "7")
        default:
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_ONE_HOUR", comment: "1")
        }
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
        case NSLocalizedString("FIFTEEN_MINUTES", comment: "15"):
            timeInSeconds = 900
            UserSettings.userIntervalNotif = timeInSeconds!
            print(UserSettings.userIntervalNotif!)
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_FIFTEEN", comment: "15")
            appDelegate?.createNotification()
        case NSLocalizedString("THIRTY_MINUTES", comment: "30"):
            timeInSeconds = 1800
            UserSettings.userIntervalNotif = timeInSeconds! 
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_THIRTY", comment: "30")
            appDelegate?.createNotification()
        case NSLocalizedString("ONE_HOUR", comment: "1"):
            timeInSeconds = 3600
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_ONE_HOUR", comment: "1 hour")
            appDelegate?.createNotification()
        case NSLocalizedString("ONE_HOUR_AND_THIRTY_MINUTES", comment: "1:30"):
            timeInSeconds = 4680
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_ONE_HOUR_AND_THIRTY", comment: "1:30")
            appDelegate?.createNotification()
        case NSLocalizedString("TWO_HOURS", comment: "2"):
            timeInSeconds = 7200
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_TWO_HOURS", comment: "2")
            appDelegate?.createNotification()
        case NSLocalizedString("TWO_HOURS_AND_THIRTY_MINUTES", comment: "2:30"):
            timeInSeconds = 8280
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_TWO_HOURS_AND_THIRTY", comment: "2:30")
            appDelegate?.createNotification()
        case NSLocalizedString("THREE_HOURS", comment: "3"):
            timeInSeconds = 10800
            UserSettings.userIntervalNotif = timeInSeconds!
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_THREE_HOURS", comment: "3")
            appDelegate?.createNotification()
        case NSLocalizedString("FOUR_HOURS", comment: "4"):
            timeInSeconds = 14400
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_FOUR_HOURS", comment: "4")
            appDelegate?.createNotification()
        case NSLocalizedString("FIVE_HOURS", comment: "5"):
            timeInSeconds = 18000
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_FIVE_HOURS", comment: "5")
            appDelegate?.createNotification()
        case NSLocalizedString("SIX_HOURS", comment: "6"):
            timeInSeconds = 21600
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_SIX_HOURS", comment: "6")
            appDelegate?.createNotification()
        case NSLocalizedString("SEVEN_HOURS", comment: "7"):
            timeInSeconds = 25200
            UserSettings.userIntervalNotif = timeInSeconds
            timeLabelOutlet.text = NSLocalizedString("INTERVAL_SEVEN_HOURS", comment: "7")
            appDelegate?.createNotification()
        default:
            break
        }
    }
}
