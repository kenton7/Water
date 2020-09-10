//
//  ActivityWomanViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class ActivityWomanViewController: UIViewController {
    
    var weightWoman: Double?
    var selectedButtonTag = 0
    var activityMedium = 0.0
    var activityHard = 0.0
    var activityFew = 0.0
    var calcWater = CalculateWater()
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var fewButtonOutlet: UIButton!
    @IBOutlet weak var mediumButtonOutlet: UIButton!
    @IBOutlet weak var manyButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boundButtons()
        
        if UserDefaults.standard.bool(forKey: "activitySet") {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(identifier: "BackToMainView")
            navigationController?.pushViewController(mainViewController, animated: false)
        }
    }
    
    @IBAction func fewButtonPressed(_ sender: UIButton) {
        fewButtonOutlet.alpha = 0.5
        mediumButtonOutlet.alpha = 1.0
        manyButtonOutlet.alpha = 1.0
        nextButtonOutlet.isUserInteractionEnabled = true
        nextButtonOutlet.alpha = 1.0
        selectedButtonTag = fewButtonOutlet.tag
        activityFew = calcWater.calculateWaterForWoman(weight: Double(UserSettings.userWeight) ?? 0)
        print(activityFew)
    }
    
    @IBAction func mediumButtonPressed(_ sender: UIButton) {
        mediumButtonOutlet.alpha = 0.5
        fewButtonOutlet.alpha = 1.0
        manyButtonOutlet.alpha = 1.0
        nextButtonOutlet.isUserInteractionEnabled = true
        nextButtonOutlet.alpha = 1.0
        selectedButtonTag = mediumButtonOutlet.tag
        activityMedium = calcWater.calculateMediumActivity(weight: Double(UserSettings.userWeight) ?? 0)
        print(activityMedium)
    }
    
    @IBAction func manyButtonPressed(_ sender: UIButton) {
        manyButtonOutlet.alpha = 0.5
        fewButtonOutlet.alpha = 1.0
        mediumButtonOutlet.alpha = 1.0
        nextButtonOutlet.isUserInteractionEnabled = true
        nextButtonOutlet.alpha = 1.0
        selectedButtonTag = manyButtonOutlet.tag
        activityHard = calcWater.calculateHardActivity(weight: Double(UserSettings.userWeight) ?? 0)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        UserSettings.userActivity = "activitySet"
        UserDefaults.standard.set(true, forKey: "activitySet")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.resultSegueWoman {
            let destinationVC = segue.destination as! ResultViewController
            
            switch selectedButtonTag {
            case 4:
                destinationVC.activityFewResult = activityFew
                destinationVC.resultString = String(format: "%.0f", activityFew)
                UserSettings.result = Int(destinationVC.resultString)
            case 5:
                destinationVC.activityMediumResult = activityMedium
                destinationVC.resultString = String(format: "%.0f", activityMedium * 1000)
                UserSettings.result = Int(destinationVC.resultString)
            case 6:
                destinationVC.activityHardResult = activityHard
                destinationVC.resultString = String(format: "%.0f", activityHard * 1000)
                UserSettings.result = Int(destinationVC.resultString)
            default:
                break
            }
        }
    }
    
    func boundButtons() {
        nextButtonOutlet.isUserInteractionEnabled = false
        nextButtonOutlet.alpha = 0.5
        nextButtonOutlet.layer.cornerRadius = 25
        nextButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        nextButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        nextButtonOutlet.layer.masksToBounds = false
        nextButtonOutlet.layer.shadowRadius = 1.0
        nextButtonOutlet.layer.shadowOpacity = 0.5
        
        fewButtonOutlet.layer.cornerRadius = 25
        fewButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        fewButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        fewButtonOutlet.layer.masksToBounds = false
        fewButtonOutlet.layer.shadowRadius = 1.0
        fewButtonOutlet.layer.shadowOpacity = 0.5
        
        mediumButtonOutlet.layer.cornerRadius = 25
        mediumButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        mediumButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        mediumButtonOutlet.layer.masksToBounds = false
        mediumButtonOutlet.layer.shadowRadius = 1.0
        mediumButtonOutlet.layer.shadowOpacity = 0.5
        
        manyButtonOutlet.layer.cornerRadius = 25
        manyButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        manyButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        manyButtonOutlet.layer.masksToBounds = false
        manyButtonOutlet.layer.shadowRadius = 1.0
        manyButtonOutlet.layer.shadowOpacity = 0.5
    }
    
}
