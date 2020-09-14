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
        water.drinkName = "Вода"
        water.imageName = "water"
        water.description = "Коэффициент гидрации = 100%"
        
        var greenTea = Drinks()
        greenTea.drinkName = "Зелёный \nчай"
        greenTea.imageName = "greenTea"
        greenTea.description = "Коэффициент гидрации = 100%"
        
        var blackTea = Drinks()
        blackTea.drinkName = "Чёрный \nчай"
        blackTea.imageName = "blackTea"
        blackTea.description = "Коэффициент гидрации = 100%"
        
        var coffee = Drinks()
        coffee.drinkName = "Кофе"
        coffee.imageName = "coffee"
        coffee.description = "Коэффициент гидрации = 90%"
        
        var cola = Drinks()
        cola.drinkName = "Кола"
        cola.imageName = "cola"
        cola.description = "Коэффициент гидрации = 89%"
        
        var dietCola = Drinks()
        dietCola.drinkName = "Кола Zero"
        dietCola.imageName = "dietCola"
        dietCola.description = "Коэффициент гидрации = 100%"
        
        var milk = Drinks()
        milk.drinkName = "Молоко"
        milk.imageName = "milk"
        milk.description = "Коэффициент гидрации = 88%"
        
        var appleJuice = Drinks()
        appleJuice.drinkName = "Яблочный \nсок"
        appleJuice.imageName = "appleJuice"
        appleJuice.description = "Коэффициент гидрации = 88%"
        
        var orangeJuice = Drinks()
        orangeJuice.drinkName = "Апельсин. \nсок"
        orangeJuice.imageName = "orangeJuice"
        orangeJuice.description = "Коэффициент гидрации = 89%"
        
        var kefir = Drinks()
        kefir.drinkName = "Кефир"
        kefir.imageName = "kefir"
        kefir.description = "Коэффициент гидрации = 91%"
        
        var wine = Drinks()
        wine.drinkName = "Вино"
        wine.imageName = "wine"
        wine.description = "Коэффициент гидрации вина рассчитывается по формуле: \n1 мл * (-0.8)"
        
        var beer = Drinks()
        beer.drinkName = "Пиво"
        beer.imageName = "beer"
        beer.description = "Коэффициент гидрации = 91%"
        
        var noAcloholBeer = Drinks()
        noAcloholBeer.drinkName = "Пиво \nбезалкогол."
        noAcloholBeer.imageName = "noAlcoholBeer"
        noAcloholBeer.description = "Коэффициент гидрации = 94%"
        
        var hardAlcohol = Drinks()
        hardAlcohol.drinkName = "Крепкий \nалкоголь"
        hardAlcohol.imageName = "hardAlcohol"
        hardAlcohol.description = "Коэффициент гидрации крепкого алкоголя расчитывается по формуле: \n1 мл * (-1.8)"
        
        var energetic = Drinks()
        energetic.drinkName = "Энергетик"
        energetic.imageName = "energyDrink"
        energetic.description = "Коэффициент гидрации энергетика рассчитывается по формуле: \n1 мл * (-0.8)"
        
        var limonad = Drinks()
        limonad.drinkName = "Лимонад"
        limonad.imageName = "lemonade"
        limonad.description = "Коэффициент гидрации лимонада рассчитывается по формуле: \n1 мл * (-0.4)"
        
        var kvass = Drinks()
        kvass.drinkName = "Квас"
        kvass.imageName = "kvass"
        kvass.description = "Коэффициент гидрации кваса рассчитывается по формуле: \n1 мл * (-0.4)"
        
        var smoothie = Drinks()
        smoothie.drinkName = "Смузи"
        smoothie.imageName = "smoothie"
        smoothie.description = "Коэффициент гидрации = 85%"
        
        var compote = Drinks()
        compote.drinkName = "Компот"
        compote.imageName = "compote"
        compote.description = "Коэффициент гидрации = 87%"
        
        var cocoa = Drinks()
        cocoa.drinkName = "Какао"
        cocoa.imageName = "cocoa"
        cocoa.description = "Коэффициент гидрации = 90%"

        return [water, greenTea, blackTea, cocoa, coffee, cola, milk, kefir, wine, beer, smoothie, kvass, dietCola, compote, limonad, energetic, noAcloholBeer, appleJuice, hardAlcohol, orangeJuice]
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
        //let cellWidth: CGFloat = (self.view.frame.width - 20.0 - (4 * 5)) / 4.0
        //let cellHeight: CGFloat = (self.view.frame.height - 260.0 - (5 * 5)) / 5.0
        //let collectionViewLayout: UICollectionViewFlowLayout = (self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout)

        //collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //collectionViewLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return CollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drinks = drinksArray[indexPath.row]
        
        switch drinks.drinkName {
        case "Вода":
            print("Вода")
        case "Зелёный \nчай":
            print("Зелёный чай")
        case "Чёрный \nчай":
            print("Чёрный чай")
        case "Какао":
            print("Какао")
        case "Кофе":
            print("Кофе")
        case "Кола":
            print("Кола")
        case "Молоко":
            print("Молоко")
        case "Кефир":
            print("Кефир")
        case "Вино":
            print("Вино")
        case "Пиво":
            print("Пиво")
        case "Смузи":
            print("Смузи")
        case "Квас":
            print("Квас")
        case "Кола Zero":
            print("Кола Zero")
        case "Компот":
            print("Компот")
        case "Лимонад":
            print("Лимонад")
        case "Энергетик":
            print("Энергетик")
        case "Пиво \nбезалкогол.":
            print("Пиво безалкогольное")
        case "Яблочный \nсок":
            print("Яблочный сок")
        case "Крепкий \nалкоголь":
            print("Крепкий алкоголь")
        case "Апельсин. \nсок":
            print("Апельсиновый сок")
        default:
            break
        }
        
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

