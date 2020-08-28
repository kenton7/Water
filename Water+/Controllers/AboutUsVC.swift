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

    @IBOutlet weak var buttonOneOutlet: UIButton!
    @IBOutlet weak var buttonTwoOutlet: UIButton!
    @IBOutlet weak var buttonThreeOutlet: UIButton!
    @IBOutlet weak var buttonFourOutlet: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = "Все знают, что вода - это жизнь. Она есть в составе любого организма, в том числе и у человека. Нарушение водного баланса может приводить к проблемам со здоровьем, поэтому так важно поддердживать водный баланс в норме! Наше приложение Вам в этом поможет! \n*Не является медицинским продуктом."
        circleButtons()
    }
    
    
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        openUrl(url: "https://www.flaticon.com/authors/smalllikeart")
    }
    
    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        openUrl(url: "https://www.flaticon.com/authors/surang")
    }
    
    @IBAction func buttonThreeTapped(_ sender: UIButton) {
        openUrl(url: "https://www.flaticon.com/authors/good-ware")
    }
    
    @IBAction func buttonFourTapped(_ sender: UIButton) {
        openUrl(url: "https://www.flaticon.com/authors/freepik")
    }
    
        func openUrl(url: String!) {
        if let url = URL(string: url), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

    }
    
    func circleButtons() {
        buttonOneOutlet.layer.cornerRadius = 15
        buttonTwoOutlet.layer.cornerRadius = 15
        buttonThreeOutlet.layer.cornerRadius = 15
        buttonFourOutlet.layer.cornerRadius = 15
    }
}
