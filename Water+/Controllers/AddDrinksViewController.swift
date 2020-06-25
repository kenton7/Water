//
//  AddDrinksViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class AddDrinksViewController: UIViewController {
    
    var drinksArray: [Drinks] = {
       var water = Drinks()
        water.drinkName = "Вода"
        water.imageName = "water"
        
        var greenTea = Drinks()
        greenTea.drinkName = "Зелёный \nчай"
        greenTea.imageName = "greenTea"
        
        var blackTea = Drinks()
        blackTea.drinkName = "Чёрный \nчай"
        blackTea.imageName = "blackTea"
        
        var coffee = Drinks()
        coffee.drinkName = "Кофе"
        coffee.imageName = "coffee"
        
        var cola = Drinks()
        cola.drinkName = "Кола"
        cola.imageName = "cola"
        
        var dietCola = Drinks()
        dietCola.drinkName = "Кола Zero"
        dietCola.imageName = "dietCola"
        
        var milk = Drinks()
        milk.drinkName = "Молоко"
        milk.imageName = "milk"
        
        var appleJuice = Drinks()
        appleJuice.drinkName = "Яблочный \nсок"
        appleJuice.imageName = "appleJuice"
        
        var orangeJuice = Drinks()
        orangeJuice.drinkName = "Апельсин. \nсок"
        orangeJuice.imageName = "orangeJuice"
        
        var kefir = Drinks()
        kefir.drinkName = "Кефир"
        kefir.imageName = "kefir"
        
        var wine = Drinks()
        wine.drinkName = "Вино"
        wine.imageName = "wine"
        
        var beer = Drinks()
        beer.drinkName = "Пиво"
        beer.imageName = "beer"
        
        var noAcloholBeer = Drinks()
        noAcloholBeer.drinkName = "Пиво \nбезалкогол."
        noAcloholBeer.imageName = "noAlcoholBeer"
        
        var hardAlcohol = Drinks()
        hardAlcohol.drinkName = "Крепкий \nалкоголь"
        hardAlcohol.imageName = "hardAlcohol"
        
        var energetic = Drinks()
        energetic.drinkName = "Энергетик"
        energetic.imageName = "energyDrink"
        
        var limonad = Drinks()
        limonad.drinkName = "Лимонад"
        limonad.imageName = "lemonade"
        
        var kvass = Drinks()
        kvass.drinkName = "Квас"
        kvass.imageName = "kvass"
        
        var smoothie = Drinks()
        smoothie.drinkName = "Смузи"
        smoothie.imageName = "smoothie"
        
        var compote = Drinks()
        compote.drinkName = "Компот"
        compote.imageName = "compote"
        
        var cocoa = Drinks()
        cocoa.drinkName = "Какао"
        cocoa.imageName = "cocoa"
        
        
        return [water, greenTea, blackTea, cocoa, coffee, cola, milk, kefir, wine, dietCola, energetic, limonad, beer, smoothie, kvass, appleJuice, noAcloholBeer, compote, hardAlcohol, orangeJuice]
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Напитки"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.milimetersView {
            if let vc = segue.destination as? MililetersViewController {
                let milimeters = sender as? Drinks
                print(milimeters ?? "nil")
                vc.drinks = milimeters
            }
        }
    }
}

extension AddDrinksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as? CollectionViewCell {
            
            cell.drinksMenu = drinksArray[indexPath.row]
            return cell
        }
        let cellWidth: CGFloat = (self.view.frame.width - 20.0 - (4 * 5)) / 4.0
        let cellHeight: CGFloat = (self.view.frame.height - 260.0 - (5 * 5)) / 5.0
        let collectionViewLayout: UICollectionViewFlowLayout = (self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout)

        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return CollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drinks = drinksArray[indexPath.row]
        self.performSegue(withIdentifier: K.milimetersView, sender: drinks)
    }
    
}

