//
//  AboutUsVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 19.07.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import Foundation

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var versionOutlet: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewOutlet.image = UIImage(named: "Icon")
        imageViewOutlet.clipsToBounds = true
        imageViewOutlet.layer.cornerRadius = 50
        textViewOutlet.text = NSLocalizedString("DESCRIPTION", comment: "descr")
        versionOutlet.text = "Версия 2.0"
    }
}

