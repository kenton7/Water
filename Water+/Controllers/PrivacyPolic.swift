//
//  AboutDrinksVC.swift
//  Water+
//
//  Created by Илья Кузнецов on 11.09.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class PrivacyPolic: UIViewController {
    
    var drinks = Drinks()
    
    @IBOutlet weak var textLabelOutlet: UILabel!
    @IBOutlet weak var imageViewOutlet: UIImageView! {
        didSet {
            guard let image = drinks.imageName else { return }
            imageViewOutlet.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var drinkNameOutlet: UILabel! {
        didSet {
            drinkNameOutlet.text = drinks.drinkName
        }
    }
    @IBOutlet weak var coefficient: UILabel! {
        didSet {
            coefficient.text = drinks.coefficient
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textLabelOutlet.text = "Здесь Вы можете узнать коэффициент гидрации каждого напитка."
    }
    

}
