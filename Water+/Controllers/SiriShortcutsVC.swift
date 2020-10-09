//
//  SiriShortcutsVC.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 01.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import IntentsUI

class SiriShortcutsVC: UIViewController, UIPickerViewDelegate {
    
    

    
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var labelOutlet: UILabel!
    let add = MilimetersScreen()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addSiriButton(to: self.view)
        
        addButtonOutlet.layer.cornerRadius = 25
        addButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButtonOutlet.layer.masksToBounds = false
        addButtonOutlet.layer.shadowRadius = 1.0
        addButtonOutlet.layer.shadowOpacity = 0.5
        
        labelOutlet.text = "Выберите напиток и его объем для настройки Siri Shortcuts."
        
    }
    
    func addShortcut() {
        let activity = NSUserActivity(activityType: "addDrink.SiriShortcuts.addDrink")
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier("addDrink.SiriShortcuts.addDrink")
        let shortcut = INShortcut(userActivity: activity)
        
        activity.title = "Выбери напиток"
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
        
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.delegate = self

        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        print("water")
        //addShortcut()
        performSegue(withIdentifier: "unwindTAddDrinksVCWithSegue", sender: self)
            //addShortcut()
    }
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SiriShortcutsVC: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}

//extension SiriShortcutsVC: INUIAddVoiceShortcutButtonDelegate {
//        @available(iOS 12.0, *)
//            func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
//                addVoiceShortcutViewController.delegate = self
//                addVoiceShortcutViewController.modalPresentationStyle = .formSheet
//                present(addVoiceShortcutViewController, animated: true, completion: nil)
//    }
//
//    @available(iOS 12.0, *)
//        func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
//            editVoiceShortcutViewController.delegate = self
//            editVoiceShortcutViewController.modalPresentationStyle = .formSheet
//            present(editVoiceShortcutViewController, animated: true, completion: nil)
//        }
//
//    func addSiriButton(to view: UIView) {
//        if #available(iOS 12.0, *) {
//            //let intent = INIntent()
//            let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
//            button.shortcut = INShortcut(intent: intent)
//                button.delegate = self
//                button.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(button)
//                view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
//                view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
//            }
//
//        }
//
//    func showMessage() {
//        let alert = UIAlertController(title: "Готово!", message: "Команда добавлена в Siri Shortcuts", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//}
//
//extension SiriShortcutsVC {
//    @available(iOS 12.0, *)
//    public var intent: DrinkWaterIntent {
//        let testIntent = DrinkWaterIntent()
//        testIntent.suggestedInvocationPhrase = "Добавить воды"
//        return testIntent
//    }
//}
//
//
//extension SiriShortcutsVC: INUIAddVoiceShortcutViewControllerDelegate {
//    @available(iOS 12.0, *)
//        func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
//            controller.dismiss(animated: true, completion: nil)
//        }
//
//        @available(iOS 12.0, *)
//        func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
//            controller.dismiss(animated: true, completion: nil)
//        }
//}
//
//extension SiriShortcutsVC: INUIEditVoiceShortcutViewControllerDelegate {
//    @available(iOS 12.0, *)
//        func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
//            controller.dismiss(animated: true, completion: nil)
//        }
//
//        @available(iOS 12.0, *)
//        func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
//            controller.dismiss(animated: true, completion: nil)
//        }
//
//        @available(iOS 12.0, *)
//        func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
//            controller.dismiss(animated: true, completion: nil)
//        }
//}

