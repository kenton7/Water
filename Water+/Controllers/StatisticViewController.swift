//
//  StatisticViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 03.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import Macaw

class StatisticViewController: UIViewController {
    
    
    @IBOutlet weak var segmentedControllOutlet: UISegmentedControl!
    @IBOutlet weak var chartView: MacawCharts!
    
    var currentDay: String?
    let delegate = MainViewController()
    var resultOfDay = 0
    
    
     override func viewDidLoad() {
           super.viewDidLoad()
        chartView.contentMode = .scaleAspectFit
        chartView.backgroundColor = .tertiarySystemBackground
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        self.tabBarController?.navigationController?.title = "Статистика"
        //self.tabBarController?.navigationItem.title = NSLocalizedString("STATISTIC", comment: "stat")
        chartView.updateData(newData: MacawCharts.chartsData())
        MacawCharts.playAnimations()
    }
    
    @IBAction func test(_ sender: UIButton) {
    }
}


