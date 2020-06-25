//
//  GenderViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class WeightManViewController: UIViewController, UITextFieldDelegate {
    
    var calculateWater = CalculateWater()
    var weightMan = 0.0
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
       override func viewDidLoad() {
         super.viewDidLoad()
        
        nextButtonOutlet?.isUserInteractionEnabled = false
        nextButtonOutlet?.alpha = 0.5
        
         nextButtonOutlet.layer.cornerRadius = nextButtonOutlet.frame.size.height / 5
         nextButtonOutlet.layer.shadowColor = UIColor.black.cgColor
         nextButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
         nextButtonOutlet.layer.masksToBounds = false
         nextButtonOutlet.layer.shadowRadius = 1.0
         nextButtonOutlet.layer.shadowOpacity = 0.5
        
        if UserDefaults.standard.bool(forKey: "weightManButtonPressed") == true {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            navigationController?.pushViewController(vc, animated: false)
        }
        
        textFieldOutlet.delegate = self
        //вызываем наблюдателя для наблюдения за появлением клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //наблюдатель для наблюдения за скрытием клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
    //функция отображения клавиатуры и подъема элементов на View
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    //скрываем клаву и возвращаем элементы обратно
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //функция, которая без выбора веса не дает нажать на кнопку "продолжить"
    //проверка на пустоту TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            nextButtonOutlet?.isUserInteractionEnabled = true
            nextButtonOutlet?.alpha = 1.0
        } else {
            nextButtonOutlet?.isUserInteractionEnabled = false
            nextButtonOutlet?.alpha = 0.5
        }
        return true
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        UserSettings.userWeight = "weightSet"
        
        if sender.isSelected {
            //записываем вес в TextField и проверяем на nil
            if let weight = Double(textFieldOutlet.text!) {
                //присваиваем главной переменной вес
                //weightMan = calculateWater.calculateWaterForMan(weight: weight)
                weightMan = weight
            }
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.activityLevelMan {
            //кастим сегвей для дальнейшей передачи информации
            let destinationVC = segue.destination as! ActivityManViewController
            //записываем вес в переменную
            weightMan = Double(textFieldOutlet.text!) ?? 0
            //в передаваемый View записываем вес
            destinationVC.weightMan = weightMan
            print(weightMan)
        }
    }
    //убираем клавиатуру
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    
}
