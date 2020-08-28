//
//  WriteToUsVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 21.08.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import MessageUI

class WriteToUsVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let mainVC = MainViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        openEmail("mwrv95@gmail.com")
        setupVisualEffectView()
    }

    
    func openEmail(_ emailAddress: String) {
        //если юзер не установил свой акк в iOS Mail app
        if !MFMailComposeViewController.canSendMail() {
            let alert = UIAlertController(title: "😞", message: "Невозможно отправить сообщение", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                self.animateOut()
                //self.present(self.mainVC, animated: true, completion: nil)
                //self.present(MainViewController(), animated: true, completion: nil)

            }))
            present(alert, animated: true, completion: nil)
            animateIn()
            let url = URL(string: "mailto:" + emailAddress)
            //UIApplication.shared.openURL(url!)
            UIApplication.shared.canOpenURL(url!)
            return
        }

        // Use the iOS Mail app
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([emailAddress])
        composeVC.setSubject("")
        composeVC.setMessageBody("", isHTML: false)

        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }

    // MARK: MailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
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
}
