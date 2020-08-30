//
//  ViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var calculateWater = CalculateWater()
    
    //скрываем nav bar на первом view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    //показываем navigation bar на остальных view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "SexSelected") {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(identifier: "WeightManVC")
            navigationController?.pushViewController(mainViewController, animated: false)
        }
        
//        if UserDefaults.standard.bool(forKey: "SexSelected") == true {
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = mainStoryboard.instantiateViewController(identifier: "MainViewController")
//            navigationController?.pushViewController(mainViewController, animated: false)
//        }
    }

    @IBAction func manSelected(_ sender: UIButton) {
        //UserSettings.userSex = "SexSelected"
        UserSettings.userSex = "SexSelected"
        UserDefaults.standard.set(true, forKey: "SexSelected")
    }
    
    @IBAction func womanSelected(_ sender: UIButton) {
        //UserSettings.userSex = "SexSelected"
        UserSettings.userSex = "SexSelected"
        UserDefaults.standard.set(true, forKey: "SexSelected")
    }
}

