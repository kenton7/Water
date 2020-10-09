//
//  AddDrinksViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class AddDrinksViewController: UIViewController {
    
    var delegate: MililetersViewController?
    
    var drinksArray: [Drinks] = {
           var water = Drinks()
            water.drinkName = NSLocalizedString("WATER", comment: "Water")
            water.imageName = "water"
            water.description = NSLocalizedString("WATER_DESCR", comment: "WeaterDescr")
            
            var greenTea = Drinks()
            greenTea.drinkName = NSLocalizedString("GREEN_TEA", comment: "Green tea")
            greenTea.imageName = "greenTea"
            greenTea.description = NSLocalizedString("GREEN_TEA_DESCR", comment: "Green_tea_descr")
            
            var blackTea = Drinks()
            blackTea.drinkName = NSLocalizedString("BLACK_TEA", comment: "Black tea")
            blackTea.imageName = "blackTea"
            blackTea.description = NSLocalizedString("BLACK_TEA_DESCR", comment: "black tea descr")
            
            var coffee = Drinks()
            coffee.drinkName = NSLocalizedString("COFFEE", comment: "Coffee")
            coffee.imageName = "coffee"
            coffee.description = NSLocalizedString("COFFEE_DESCR", comment: "Coffee descr")
            
            var cola = Drinks()
            cola.drinkName = NSLocalizedString("COLA", comment: "Cola")
            cola.imageName = "cola"
            cola.description = NSLocalizedString("COLA_DESCR", comment: "Cola descr")
            
            var dietCola = Drinks()
            dietCola.drinkName = NSLocalizedString("COLA_ZERO", comment: "Cola Zero")
            dietCola.imageName = "dietCola"
            dietCola.description = NSLocalizedString("COLA_ZERO_DESCR", comment: "Cola zero descr")
            
            var milk = Drinks()
            milk.drinkName = NSLocalizedString("MILK", comment: "Milk")
            milk.imageName = "milk"
            milk.description = NSLocalizedString("MILK_DESCR", comment: "milk descr")
            
            var appleJuice = Drinks()
            appleJuice.drinkName = NSLocalizedString("APPLE_JUICE", comment: "Apple Juice")
            appleJuice.imageName = "appleJuice"
            appleJuice.description = NSLocalizedString("APPLE_JUICE_DESCR", comment: "apple juice descr")
            
            var orangeJuice = Drinks()
            orangeJuice.drinkName = NSLocalizedString("ORANGE_JUICE", comment: "Orange Juice")
            orangeJuice.imageName = "orangeJuice"
            orangeJuice.description = NSLocalizedString("ORANGE_JUICE_DECR", comment: "orange juice descr")
            
            var kefir = Drinks()
            kefir.drinkName = NSLocalizedString("KEFIR", comment: "Kefir")
            kefir.imageName = "kefir"
            kefir.description = NSLocalizedString("KEFIR_DESCR", comment: "kefir descr")
            
            var wine = Drinks()
            wine.drinkName = NSLocalizedString("WINE", comment: "Wine")
            wine.imageName = "wine"
            wine.description = NSLocalizedString("WINE_DESCR", comment: "wine descr")
            
            var beer = Drinks()
            beer.drinkName = NSLocalizedString("BEER", comment: "Beer")
            beer.imageName = "beer"
            beer.description = NSLocalizedString("BEER_DESCR", comment: "beer descr")
            
            var noAcloholBeer = Drinks()
            noAcloholBeer.drinkName = NSLocalizedString("NO_ALCOHOL_BEER", comment: "No alcohol beer")
            noAcloholBeer.imageName = "noAlcoholBeer"
            noAcloholBeer.description = NSLocalizedString("NO_ALCOHOL_BEER_DESCR", comment: "no alcohol descr")
            
            var hardAlcohol = Drinks()
            hardAlcohol.drinkName = NSLocalizedString("HARD_ALCOHOL", comment: "Strong alcohol")
            hardAlcohol.imageName = "hardAlcohol"
            hardAlcohol.description = NSLocalizedString("HARD_ALCOHOL_DESCR", comment: "hard alcohol descr")
            
            var energetic = Drinks()
            energetic.drinkName = NSLocalizedString("ENERGETIC", comment: "Energetic")
            energetic.imageName = "energyDrink"
            energetic.description = NSLocalizedString("ENERGETIC_DESCR", comment: "Energetic descr")
            
            var limonad = Drinks()
            limonad.drinkName = NSLocalizedString("LIMONAD", comment: "lemonade")
            limonad.imageName = "lemonade"
            limonad.description = NSLocalizedString("LIMONAD_DESCR", comment: "lemonade descr")
            
            var kvass = Drinks()
            kvass.drinkName = NSLocalizedString("KVASS", comment: "Kvass")
            kvass.imageName = "kvass"
            kvass.description = NSLocalizedString("KVASS_DESCR", comment: "kvass descr")
            
            var smoothie = Drinks()
            smoothie.drinkName = NSLocalizedString("SMOOTHIE", comment: "Smoothie")
            smoothie.imageName = "smoothie"
            smoothie.description = NSLocalizedString("SMOOTHIE_DESCR", comment: "Smoothie descr")
            
            var compote = Drinks()
            compote.drinkName = NSLocalizedString("COMPOTE", comment: "Compote")
            compote.imageName = "compote"
            compote.description = NSLocalizedString("COMPOTE_DESCR", comment: "compote descr")
            
            var cocoa = Drinks()
            cocoa.drinkName = NSLocalizedString("COCOA", comment: "Cocoa")
            cocoa.imageName = "cocoa"
            cocoa.description = NSLocalizedString("COCOA_DESCR", comment: "cocoa descr")
            
            return [water, greenTea, blackTea, cocoa, coffee, cola, milk, kefir, wine, beer, smoothie, kvass, dietCola, compote, limonad, energetic, noAcloholBeer, appleJuice, hardAlcohol, orangeJuice]
        }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.title = NSLocalizedString("DRINKS", comment: "drinks")
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
    
    @IBAction func unwindTAddDrinksVC(segue: UIStoryboardSegue) {
        
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
        //let cellWidth: CGFloat = (self.view.frame.width - 20.0 - (4 * 5)) / 4.0
        //let cellHeight: CGFloat = (self.view.frame.height - 260.0 - (5 * 5)) / 5.0
        //let collectionViewLayout: UICollectionViewFlowLayout = (self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout)

        //collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return CollectionViewCell()
    }
    
    func test() {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let drinks = drinksArray[indexPath.row]

            
            self.performSegue(withIdentifier: K.milimetersView, sender: drinks)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drinks = drinksArray[indexPath.row]

        
        self.performSegue(withIdentifier: K.milimetersView, sender: drinks)
    }
    //размер иконок
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    //расстояние между краями экрана и иконками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
    
}

