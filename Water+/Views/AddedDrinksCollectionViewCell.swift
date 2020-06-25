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
    
    private let circleAddedDrinksImages: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100.0/2.0
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.link.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(circleAddedDrinksImages)
    }
    
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
