//
//  CollectionViewCell.swift
//  Water+
//
//  Created by Илья Кузнецов on 07.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    
    var drinksMenu: Drinks? {
        didSet {
            labelOutlet.text = drinksMenu?.drinkName
            if let image = drinksMenu?.imageName {
                imageViewOutlet.image = UIImage(named: image)
            }
        }
    }
}
