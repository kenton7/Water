//
//  MililetersViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 13.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

protocol MililetersVCDelegate {
    func passingDataBack(data: [String])
}

import UIKit

class MililetersViewController: UIViewController, UIViewControllerTransitioningDelegate, MililetersVCDelegate {
    func passingDataBack(data: [String]) {
        self.delegate?.passingDataBack(data: arrayVolumes)
    }
    
    
    @IBOutlet weak var imageOutlet: UIImageView! {
        didSet {
            guard let image = drinks?.imageName else { return }
            imageOutlet.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var drinkNameOutlet: UILabel! {
        didSet {
            drinkNameOutlet.text = drinks?.drinkName
        }
    }
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    var arrayVolumes = [""]
    var volumeFromMilimetersVC = 0
    var volumeFromMilimeters2 = 0
    var drinks: Drinks?
    var volume = MilimetersScreen()
    var delegate: MililetersVCDelegate?
    var main = MainViewController()
    var addDrinks = AddDrinksViewController()
    var drinksToMainVC: [String] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewOutlet.dataSource = self
        pickerViewOutlet.delegate = self
        self.transitioningDelegate = self
        
        addButtonOutlet.layer.cornerRadius = addButtonOutlet.frame.size.height / 5
        addButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButtonOutlet.layer.masksToBounds = false
        addButtonOutlet.layer.shadowRadius = 1.0
        addButtonOutlet.layer.shadowOpacity = 0.5
        
        
        
    }
    
    
    @IBAction func goToMainVC(_ sender: UIButton) {
        performSegue(withIdentifier: K.BackToMainView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MainViewController
        vc?.delegate = self
        vc?.addVolume(volumeFromMilimetersVC)
        vc?.addedDrinksArray.append(contentsOf: drinksToMainVC)
    }
    
    
}

extension MililetersViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //кол-во столбцов в picker view
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return volume.volumeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //название элементов в picker view
        return String(volume.volumeArray[row]) + " " + "мл"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        volumeFromMilimetersVC = volume.volumeArray[row]
        drinksToMainVC.append(drinks?.imageName ?? "nil")
        //UserSettings.addedVolume = String(volumeFromMilimetersVC)
        //UserDefaults.standard.set(true, forKey: String(volumeFromMilimetersVC))
    }
    
    //высота между элементами
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
}
