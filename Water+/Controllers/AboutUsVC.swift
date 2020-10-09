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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewOutlet.image = UIImage(named: "Icon")
        textViewOutlet.text = NSLocalizedString("DESCRIPTION", comment: "descr")
    }
}

