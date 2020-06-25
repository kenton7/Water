//
//  MainViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    let shapeLayer = CAShapeLayer()
    var resultString = ""
    var delegate: MililetersVCDelegate?
    let defaults = UserDefaults.standard
    let beginingOfDay = NSCalendar.current.startOfDay(for: NSDate() as Date)
    var currentTime = 0
    private var addedDrinksCollectionView: UICollectionView?
    var addedDrinksArray: [String] {
        get {
            return UserDefaults.standard.array(forKey: "savedArray") as? [String] ?? []
        } set {
            UserDefaults.standard.set(newValue, forKey: "savedArray")
        }
    }
    
    public var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }
    
    //переменная с computed property для получения новых данных
    var volume: Int = 0 {
        didSet {
            updateVolumeLabel(with: volume)
        }
    }
    
    @IBOutlet weak var addedDrinksLabel: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Главная"
        
        checkAddedDrinksAndUpdateLabel()
        print(addedDrinksArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonOutlet.layer.cornerRadius = addButtonOutlet.frame.size.height / 5
        addButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButtonOutlet.layer.masksToBounds = false
        addButtonOutlet.layer.shadowRadius = 1.0
        addButtonOutlet.layer.shadowOpacity = 0.5
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        addedDrinksCollectionView?.delegate = self
        addedDrinksCollectionView?.dataSource = self
        
        
        let center = view.center
        
        //создаем слой трекинга
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        //обновляем лейбл с результатом кол-ва воды при запуске приложения и сохраняем результат добавленного юзером объема воды
        DispatchQueue.main.async {
            
            self.resultValue.text = UserSettings.result
            self.volume = UserSettings.addedVolume
            self.defaults.set(self.volume, forKey: String(UserSettings.addedVolume))
            self.currentValue.text = String(UserSettings.addedVolume) + " " + "/"
            
            UserDefaults.standard.synchronize()
        }
        print(addedDrinksArray)
    }
    
    
    @objc private func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: K.basicAnimation)
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basicAn")
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {

    }
    
    @IBAction func unwindToMainVC(segue:UIStoryboardSegue) {}
    
    func updateProgress() {
        shapeLayer.strokeEnd = progress
    }
    
    //функция для добавления нового выбранного объема напитка
    public func addVolume(_ value: Int) {
        volume += value
        //UserSettings.addedVolume = String(value)
    }
    
    //обновляем лейбл
    private func updateVolumeLabel(with value: Int) {
        //форматируем и выводим текст в лейбле
        let text = value
        //currentValue.text = text + " " + "/"
        //UserSettings.addedVolume = String(value)
        
        //сохраняем текущую дату пользователя
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let str = df.string(from: Date())
        UserDefaults.standard.setValue(str, forKey: "CurrentDate")

        //проверяем дату
        if let strOut = UserDefaults.standard.string(forKey: "CurrentDate") {
            currentValue.text = String(UserSettings.addedVolume) + " " + "/"
            print(strOut)
        } else {
            currentValue.text = "0"
            resultValue.text = UserSettings.result
        }
        
        UserSettings.addedVolume = text
        currentValue.text = String(UserSettings.addedVolume) + " " + "/"
        defaults.set(text, forKey: String(UserSettings.addedVolume))
        //UserDefaults.standard.set(true, forKey: UserSettings.addedVolume)
    }
    
    //сбрасываем лейбл в 12 ночи каждого дня
    func resetLabelEveryNight() {
        let dateComparisionResult: ComparisonResult = NSDate().compare(beginingOfDay)

        if dateComparisionResult == ComparisonResult.orderedDescending || dateComparisionResult == ComparisonResult.orderedSame {
            currentValue.text = "0" //reset the time tracker
        }
    }
    
    //MARK: - Обновляем лейбл "вы не добавили ни одного напитка" после добавления напитика
    func checkAddedDrinksAndUpdateLabel() {
        if currentValue.text == "0" {
            addedDrinksLabel.text = "Вы не добавили ни одного напитика"
        } else {
            //обноявлем лейбл добавленными напитками
            addedDrinksLabel.isHidden = true
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            addedDrinksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            addedDrinksCollectionView?.showsHorizontalScrollIndicator = false
            addedDrinksCollectionView?.delegate = self
            addedDrinksCollectionView?.dataSource = self
            addedDrinksCollectionView?.backgroundColor = .systemBackground
            addedDrinksCollectionView?.register(AddedDrinksCollectionViewCell.self, forCellWithReuseIdentifier: K.identifierAddedDrinksCollectionView)
            guard let collectionViewDrinks = addedDrinksCollectionView else { return }
            UserDefaults.standard.set(addedDrinksArray, forKey: "savedArray")
            view.addSubview(collectionViewDrinks)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addedDrinksCollectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 100).integral
    }
}

//MARK: - extension MainViewController

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedDrinksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = addedDrinksCollectionView?.dequeueReusableCell(withReuseIdentifier: K.identifierAddedDrinksCollectionView, for: indexPath) as! AddedDrinksCollectionViewCell
        cell.configure(with: addedDrinksArray[indexPath.row])
        return cell
    }
}

//extension Date {
//
//    func format(format: String = "dd-MM-yyyy hh-mm-ss") -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        let dateString = dateFormatter.string(from: self)
//        if let newDate = dateFormatter.date(from: dateString) {
//            let defaults = UserDefaults.standard
//            defaults.set(newDate, forKey: UserSettings.userDate)
//            return newDate
//        } else {
//            let dataFromMainVC = MainViewController()
//            dataFromMainVC.currentValue.text = "0"
//            return self
//        }
//    }
//}





