//
//  AboutDrinksVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 11.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class PrivacyPolicy: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://kenton7.github.io/Water/") {
            UIApplication.shared.open(url)
        }
    }
}
