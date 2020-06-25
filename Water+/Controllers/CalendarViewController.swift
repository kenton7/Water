//
//  CalendarViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 03.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

import UIKit

class CalendarViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Календарь"
    }
    
     override func viewDidLoad() {
           super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
}
