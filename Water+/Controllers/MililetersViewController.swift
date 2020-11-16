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
import IntentsUI
import AudioToolbox
import HealthKit

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
    var addDrinks = AddDrinksViewController()
    var drinksToMainVC: [String] = []
    var progressToMainVC: Float = 0.0
    private let userHealthProfile = UserHealthProfile()
    var waterMl: Double = 0
    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewOutlet.dataSource = self
        pickerViewOutlet.delegate = self
        self.transitioningDelegate = self
        
        addButtonOutlet.layer.cornerRadius = 25
        addButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButtonOutlet.layer.masksToBounds = false
        addButtonOutlet.layer.shadowRadius = 1.0
        addButtonOutlet.layer.shadowOpacity = 0.5
        descr.layer.cornerRadius = 25
    }
    
    private func loadAndDisplayMostRecentHeight() {
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
          print("Height Sample Type is no longer available in HealthKit")
          return
        }
            
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
              
          guard let sample = sample else {
              
            if let error = error {
              self.displayAlert(for: error)
            }
                
            return
          }
              
          //2. Convert the height sample to meters, save to the profile model,
          //   and update the user interface.
          let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
          self.userHealthProfile.heightInMeters = heightInMeters
        }
    }
    
    private func loaadWater() {
        guard let water = HKSampleType.quantityType(forIdentifier: .dietaryWater) else {
            print("error")
            return
        }
        ProfileDataStore.getMostRecentSample(for: water) { (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            let waterInVolume = sample.quantity.doubleValue(for: HKUnit.literUnit(with: .milli))
            self.userHealthProfile.water = waterInVolume
        }
    }
    
    private func loadAndDisplayMostRecentWeight() {
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
          print("Water Sample Type is no longer available in HealthKit")
          return
        }
            
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
              
          guard let sample = sample else {
                
            if let error = error {
              self.displayAlert(for: error)
            }
            return
          }
              
          let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
          self.userHealthProfile.weightInKilograms = weightInKilograms
        }

    }
    
    private func displayAlert(for error: Error) {
      
      let alert = UIAlertController(title: nil,
                                    message: error.localizedDescription,
                                    preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: nil))
      
      present(alert, animated: true, completion: nil)
    }
    
    class func saveWater(water: Double, date: Date) {
      
      //1.  Make sure type exists
      guard let waterCount = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
        fatalError("Body Mass Index Type is no longer available in HealthKit")
      }
        
      //2.  Use the LiterUnit to create a milileters quantity
        let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli),
                                        doubleValue: water)
        
      let waterSample = HKQuantitySample(type: waterCount,
                                                 quantity: waterQuantity,
                                                 start: date,
                                                 end: date)
        
      //3.  Save the same to HealthKit
      HKHealthStore().save(waterSample) { (success, error) in
          
        if let error = error {
          print("Error Saving Water Sample: \(error.localizedDescription)")
        } else {
          print("Successfully saved Water Sample")
        }
      }
    }
    
    private func saveWaterToHealthKit() {
        guard let waterCount = userHealthProfile.water else {
            print("error!")
          return
        }
        print(waterCount)
        ProfileDataStore.saveWaterSample(water: waterCount,
                                                 date: Date())
    }
    
    @IBAction func goToMainVC(_ sender: UIButton) {
        drinksToMainVC.append(drinks?.imageName ?? "nil")
        impactMed.impactOccurred()
        saveWaterToHealthKit()
        performSegue(withIdentifier: K.BackToMainView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MainViewController
        vc?.delegate = self
        vc?.addVolume(Int(volumeFromMilimetersVC))
        vc?.addedDrinksArray.insert(contentsOf: drinksToMainVC, at: 0)
        vc?.updateProgress(with: Float(volumeFromMilimetersVC))
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
        return String(volume.volumeArray[row]) + " " + NSLocalizedString("ML", comment: "ml")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        volumeFromMilimetersVC = Double(volume.volumeArray[row])
        userHealthProfile.water = volumeFromMilimetersVC
        progressToMainVC = Float(volumeFromMilimetersVC)
        //addShortcut()
        
        
        switch drinks?.drinkName {
        case "Вода", "Water", "L'eau", "Wasser", "Acqua":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
            impactMed.impactOccurred()
        case "Зелёный \nчай", "Green \ntea", "Thé vert", "Grüner Tee", "Tè verde":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
            impactMed.impactOccurred()
            //addSiriButton(to: self.view)
            print(volumeFromMilimetersVC)
        case "Чёрный \nчай", "Black \ntea", "Thé noir", "Schwarzer Tee", "Tè nero":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
            impactMed.impactOccurred()
        case "Какао", "Cocoa", "Cacao", "Kakao":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.9
            impactMed.impactOccurred()
        case "Кофе", "Coffee", "Café", "Kaffee", "Caffè":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.9
            impactMed.impactOccurred()
        case "Кола", "Cola":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.89
            impactMed.impactOccurred()
        case "Молоко", "Milk", "Lait", "Milch", "Latte":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.88
            impactMed.impactOccurred()
        case "Кефир", "Kefir", "Kéfir":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.91
            impactMed.impactOccurred()
        case "Вино", "Wine", "Du vin", "Wein", "Vino":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.86
            impactMed.impactOccurred()
        case "Пиво", "Beer", "Bière", "Bier", "Birra":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.91
            impactMed.impactOccurred()
        case "Смузи", "Smoothie":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.85
            impactMed.impactOccurred()
        case "Квас", "Kvass", "Kwas", "Kvas":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.9
            impactMed.impactOccurred()
        case "Кола Zero", "Cola Zero", "Cola Zéro":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 1.0
            impactMed.impactOccurred()
        case "Компот", "Compote", "Kompott", "Composta":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.87
            impactMed.impactOccurred()
        case "Лимонад", "Lemonade", "Limonade", "Limonata":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.89
            impactMed.impactOccurred()
        case "Энергетик", "Energy Drink", "Boisson \nénergisante", "Energiegetränk", "Bevanda \nenergetica":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.89
            impactMed.impactOccurred()
        case "Пиво \nбезалкогол.", "Beer \nnonalcoholic", "Bière sans \nalcool", "Alkoholfreies \nBier", "Birra \nanalcolica":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.94
            impactMed.impactOccurred()
        case "Яблочный \nсок", "Apple \njuice", "Jus de \npomme", "Apfelsaft", "Succo di \nmela":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.88
            impactMed.impactOccurred()
        case "Крепкий \nалкоголь", "Strong \nalcohol", "Alcool fort", "Starker \nAlkohol", "Alcol \nforte":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.62
            impactMed.impactOccurred()
        case "Апельсин. \nсок", "Orange \njuice", "Du jus \nd'orange", "Orangensaft", "Succo \nd'arancia":
            volumeFromMilimetersVC = Double(volume.volumeArray[row]) * 0.89
            impactMed.impactOccurred()
        default:
            break
        }
    }
    
    //высота между элементами
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
}

extension MililetersViewController: INUIAddVoiceShortcutButtonDelegate {
        @available(iOS 12.0, *)
            func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
                addVoiceShortcutViewController.delegate = self
                addVoiceShortcutViewController.modalPresentationStyle = .formSheet
                present(addVoiceShortcutViewController, animated: true, completion: nil)
    }

    @available(iOS 12.0, *)
        func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
            editVoiceShortcutViewController.delegate = self
            editVoiceShortcutViewController.modalPresentationStyle = .formSheet
            present(editVoiceShortcutViewController, animated: true, completion: nil)
        }

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

    func showMessage() {
        let alert = UIAlertController(title: "Готово!", message: "Команда добавлена в Siri Shortcuts", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//extension MililetersViewController {
//    @available(iOS 12.0, *)
//    public var intent: DrinkWaterIntent {
//        let testIntent = DrinkWaterIntent()
//        testIntent.suggestedInvocationPhrase = "Добавить воды"
//        let interaction = INInteraction(intent: testIntent, response: nil)
//        interaction.donate { (error) in
//            print(error?.localizedDescription)
//        }
//        return testIntent
//    }
//}

extension MililetersViewController: INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
        func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }

        @available(iOS 12.0, *)
        func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
}

extension MililetersViewController: INUIEditVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
        func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }

        @available(iOS 12.0, *)
        func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
            controller.dismiss(animated: true, completion: nil)
        }

        @available(iOS 12.0, *)
        func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
}


//extension MililetersViewController: INUIAddVoiceShortcutViewControllerDelegate {
//    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//}

