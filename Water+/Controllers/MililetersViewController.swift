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

class MililetersViewController: UIViewController, UIViewControllerTransitioningDelegate, MililetersVCDelegate, UITextFieldDelegate {
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
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = drinks?.description
        }
    }
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var descr: UILabel!
    
    
    var arrayVolumes = [""]
    var volumeFromMilimetersVC = 0.0
    var drinks: Drinks?
    var volume = MilimetersScreen()
    var delegate: MililetersVCDelegate?
    //var main = MainViewController()
    var addDrinks = AddDrinksViewController()
    var drinksToMainVC: [String] = []
    var progressToMainVC: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewOutlet.dataSource = self
        pickerViewOutlet.delegate = self
        //textField.delegate = self
        self.transitioningDelegate = self

        addButtonOutlet.layer.cornerRadius = 25
        addButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButtonOutlet.layer.masksToBounds = false
        addButtonOutlet.layer.shadowRadius = 1.0
        addButtonOutlet.layer.shadowOpacity = 0.5
        descr.layer.cornerRadius = 25
    }
    
    
    @IBAction func goToMainVC(_ sender: UIButton) {
        performSegue(withIdentifier: K.BackToMainView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MainViewController
        vc?.delegate = self
        vc?.addVolume(Int(volumeFromMilimetersVC))
        vc?.addedDrinksArray.insert(contentsOf: drinksToMainVC, at: 0)
        //vc?.updateProgress(with: Float(vc?.volume ?? 0))
        //vc?.updateProgress(with: Float(vc?.volume ?? 0))
        vc?.updateProgress(with: Float(volumeFromMilimetersVC))
        //vc?.updateProgress(with: progressToMainVC)
    
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
        
        volumeFromMilimetersVC = Double(volume.volumeArray[row])
        drinksToMainVC.append(drinks?.imageName ?? "nil")
        progressToMainVC = Float(volumeFromMilimetersVC)
        
        switch drinks?.drinkName {
        case "Вода":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
            print(volumeFromMilimetersVC)
        case "Зелёный \nчай":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
            print(volumeFromMilimetersVC)
        case "Чёрный \nчай":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
        case "Какао":
            volumeFromMilimetersVC = Double(volume.volumeArray[row])
        case "Кофе":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.9
        case "Кола":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.89
        case "Молоко":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.88
        case "Кефир":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.91
        case "Вино":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.86
        case "Пиво":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.91
        case "Смузи":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.85
        case "Квас":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * (-0.4)
        case "Кола Zero":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
        case "Компот":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.87
        case "Лимонад":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * (-0.4)
        case "Энергетик":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * (-0.8)
        case "Пиво \nбезалкогол.":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.94
        case "Яблочный \nсок":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.88
        case "Крепкий \nалкоголь":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.62
        case "Апельсин. \nсок":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.89
        default:
            break
        }
    }
    
    //высота между элементами
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
}

