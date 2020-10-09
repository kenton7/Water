//
//  EditDailyNormalVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 04.07.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class EditDailyNormalVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var currentDailyNormal: UILabel!
    @IBOutlet weak var customNormalTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    var delegateMainVC: MainViewController?
    var progressToMainVC: Float = 0.0
    var newDailyFromEditDailyVC = 0
    var newMaxProgress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNormalTextField.delegate = self
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: customNormalTextField.frame.height - 2, width: customNormalTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        customNormalTextField.borderStyle = .none
        customNormalTextField.layer.addSublayer(bottomLine)
        currentDailyNormal.text = String(UserSettings.result)
    }
    
    //проверка на количество знаков в textField'e, чтобы юзер не смог ввести новую норму НЕ в миллилитрах
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (customNormalTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.count < 4 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        return true
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.currentDailyNormal.text = self.customNormalTextField.text
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.BackToMainView, sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let vc = segue.destination as? MainViewController
        let newDaily = customNormalTextField.text ?? ""
        newDailyFromEditDailyVC = Int(newDaily) ?? 0
        progressToMainVC = Float(newDailyFromEditDailyVC)
        vc?.newDaily(newDaily)
        newMaxProgress = Float(newDaily)!
        UserSettings.result = Int(newDaily)
        DispatchQueue.main.async {
            vc?.maxProgress = Int(self.newMaxProgress)
            if vc!.progressBar.progressLayer.strokeEnd >= 1.0 {
                vc!.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                vc!.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
                UserSettings.alert = false
            }
        }
    }
    
    //убираем клавиатуру
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
