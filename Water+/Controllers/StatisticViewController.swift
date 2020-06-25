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
    @IBOutlet weak private var chartView: MacawCharts!
    
    
     override func viewDidLoad() {
           super.viewDidLoad()
        segmentedControllOutlet.setTitle("По месяцам", forSegmentAt: 2)
        chartView.contentMode = .scaleAspectFit
        MacawCharts.playAnimations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Статистика"
    }
    
    
}


