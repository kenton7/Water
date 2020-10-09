//
//  AddedDrinksCollectionViewCell.swift
//  Water+
//
//  Created by Илья Кузнецов on 20.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class AddedDrinksCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = K.identifierAddedDrinksCollectionView
    //let drinks = Drinks()
    //let main = MainViewController()
    
    let circleAddedDrinksImages: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100.0/2.0
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(circleAddedDrinksImages)

        //setupConstraints()
        //contentView.addSubview(drinkName)
    }
    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            //circleAddedDrinksImages.topAnchor.constraint(equalTo: circleAddedDrinksImages.topAnchor, constant: 5),
//            circleAddedDrinksImages.bottomAnchor.constraint(equalTo: main.progressBar.topAnchor, constant: 10),
//            circleAddedDrinksImages.centerXAnchor.constraint(equalTo: centerXAnchor),
//            circleAddedDrinksImages.leadingAnchor.constraint(equalTo: leadingAnchor),
//            circleAddedDrinksImages.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleAddedDrinksImages.frame = contentView.bounds
    }
    
    public func configure(with name: String) {
        circleAddedDrinksImages.image = UIImage(named: name)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        circleAddedDrinksImages.image = nil
    }
}




