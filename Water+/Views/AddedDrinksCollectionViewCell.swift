//
//  AddedDrinksCollectionViewCell.swift
//  Water+
//
//  Created by Илья Кузнецов on 20.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class AddedDrinksCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = K.identifierAddedDrinksCollectionView
    let drinks = Drinks()
    
    private let circleAddedDrinksImages: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100.0/2.0
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        return imageView
    }()
    
    let descriptionDrink: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textColor = .black
        description.textAlignment = .center
        description.font = UIFont(name: "Avenir-Heavy", size: 13)
        return description
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(circleAddedDrinksImages)
        contentView.addSubview(descriptionDrink)
        
        setupConstraints()
        //contentView.addSubview(drinkName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionDrink.topAnchor.constraint(equalTo: circleAddedDrinksImages.bottomAnchor, constant: 5),
            descriptionDrink.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionDrink.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionDrink.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleAddedDrinksImages.frame = contentView.bounds
        descriptionDrink.bounds = contentView.frame
    }
    
    public func configure(with name: String) {
        circleAddedDrinksImages.image = UIImage(named: name)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        circleAddedDrinksImages.image = nil
        descriptionDrink.text = nil
    }
}




