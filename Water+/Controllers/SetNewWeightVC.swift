//
//  SetNewWeightVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.07.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class SetNewWeightVC: UIViewController, UITextFieldDelegate {
    
    var changedWeight = ""
    var calcWater = CalculateWater()
    var newDaily = 0
    
    @IBOutlet weak var currentWeightOutlet: UILabel!
    @IBOutlet weak var newWeightTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newWeightTextField.delegate = self
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: newWeightTextField.frame.height - 2, width: newWeightTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        newWeightTextField.borderStyle = .none
        newWeightTextField.layer.addSublayer(bottomLine)
        
        currentWeightOutlet.text = UserSettings.userWeight
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (newWeightTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        return true
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.BackToMainView, sender: self)
        DispatchQueue.main.async {
            UserSettings.userWeight = self.newWeightTextField.text
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let vc = segue.destination as? MainViewController
        let newWeight = newWeightTextField.text ?? "no value"
        changedWeight = newWeight
        let changedWeightDouble = Double(changedWeight)!
        UserSettings.userWeight = changedWeight
        
        func updateProgressBarColor() {
        DispatchQueue.main.async {
            if vc!.progressBar.progressLayer.strokeEnd >= 1.0 {
                vc!.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                vc!.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
                UserSettings.alert = false
            }
        }
    }
        
        if UserDefaults.standard.bool(forKey: "activityFewSaved") {
            DispatchQueue.main.async {
                let newResult = Double(self.calcWater.calculateWaterForMan(weight: changedWeightDouble))
                UserSettings.result = Int.init(newResult)
                vc?.newDaily(String(UserSettings.result))
                UserSettings.result = Int.init(newResult)
                vc?.resultValue.text = String(UserSettings.result)
                vc?.newDaily(String(UserSettings.result))
                updateProgressBarColor()
            }
        } else if UserDefaults.standard.bool(forKey: "activityMediumSaved") {
            DispatchQueue.main.async {
                let newResult = Double(self.calcWater.calculateMediumActivity(weight: changedWeightDouble)) * 1000
                UserSettings.result = Int.init(newResult)
                print(self.calcWater.calculateMediumActivity(weight: changedWeightDouble))
                vc?.resultValue.text = String(UserSettings.result)
                vc?.newDaily(String(UserSettings.result))
                updateProgressBarColor()
            }
        } else if UserDefaults.standard.bool(forKey: "activityHardSaved") {
            DispatchQueue.main.async {
                let newResult = Double(self.calcWater.calculateHardActivity(weight: changedWeightDouble)) * 1000
                UserSettings.result = Int.init(newResult)
                vc?.resultValue.text = String(UserSettings.result)
                vc?.newDaily(String(UserSettings.result))
                updateProgressBarColor()
            }
        }
    }
    //убираем клавиатуру
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

