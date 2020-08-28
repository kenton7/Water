//
//  ResultViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var weightWoman: Double?
    var activityFewResult = 0.0
    var activityMediumResult = 0.0
    var activityHardResult = 0.0
    var resultString = ""
    var selectedButtonTag = 0
    
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonOutlet.layer.cornerRadius = 25
        nextButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        nextButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        nextButtonOutlet.layer.masksToBounds = false
        nextButtonOutlet.layer.shadowRadius = 1.0
        nextButtonOutlet.layer.shadowOpacity = 0.5
        UserSettings.result = resultString
        resultValue.text = UserSettings.result
        print(resultString)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        selectedButtonTag = nextButtonOutlet.tag
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainView" {
            let destinationVC = segue.destination as! MainViewController

            switch selectedButtonTag {
            case 7:
                destinationVC.resultString = UserSettings.result
            default:
                break
            }
        }
    }
}
