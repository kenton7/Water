//
//  HealthKitVC.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 31.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitVC: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var healthKitLogo: UIImageView!
    
    
    private let userHealthProfile = UserHealthProfile()
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectButton.layer.cornerRadius = connectButton.frame.height / 2
        healthKitLogo.layer.cornerRadius = 50
        healthKitLogo.layer.borderWidth = 1
        healthKitLogo.layer.borderColor = UIColor.black.cgColor
        descriptionLabel.text = NSLocalizedString("APPLE_HEALTH", comment: "health")
        if UserDefaults.standard.bool(forKey: "healthKitAuthorized") {
            //connectButton.isUserInteractionEnabled = false
            connectButton.alpha = 0.5
            connectButton.setTitle(NSLocalizedString("CONNECT_APPLE_HEALTH_BUTTON", comment: "button"), for: .normal)
        } else {
            //connectButton.isUserInteractionEnabled = true
            connectButton.alpha = 1.0
        }
        
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    //функция включения анимации блюра
    func animateIn() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1.0
        }
    }
    //выключаем блюр
    func animateOut() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 0
        }
    }
    
    private func authorizeHealthKit() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            DispatchQueue.main.async {
                self.connectButton.setTitle("Отключить", for: .normal)
                let alert = UIAlertController(title: "", message: NSLocalizedString("HEALTHKIT_ALERT", comment: "alert"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { (_) in
                    self.animateOut()
                }))
                //alert.addAction(actionAlert)
                self.present(alert, animated: true, completion: nil)
                self.animateIn()
                self.connectButton.alpha = 0.5
                self.connectButton.setTitle(NSLocalizedString("CONNECT_APPLE_HEALTH_BUTTON", comment: "button"), for: .normal)
            }
            UserDefaults.standard.setValue(true, forKey: "healthKitAuthorized")
            print("HealthKit Successfully Authorized.")
        }
    }
    
    
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        authorizeHealthKit()
    }
    
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    
    
}
