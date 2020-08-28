//
//  MainViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var maxProgress = Float(UserSettings.result)
    
    private var progress: Float = 0
    var resultString = ""
    var delegate: MililetersVCDelegate?
    let defaults = UserDefaults.standard
    var addedDrinksCollectionView: UICollectionView?
    let milileters = MilimetersScreen()
    let milileters2 = MililetersViewController()
    var day: DaysOfWeek?
    var addedDrinksArray: [String] {
        get {
            return UserDefaults.standard.array(forKey: "savedArray") as? [String] ?? []
        } set {
            UserDefaults.standard.set(newValue, forKey: "savedArray")
        }
    }
    var currentDay: String?
    var resultOfDay = 0
    let drinks = Drinks()

    
    //переменная с computed property для получения новых данных
    var volume: Int = 0 {
        didSet {
            updateVolumeLabel(with: volume)
        }
    }
    
    var newNormal: String = "" {
        didSet {
            updateNewDailyNormal(with: newNormal)
        }
    }
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var addedDrinksLabel: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var progressBar: ProgressBarView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Главная"
        
        checkAddedDrinksAndUpdateLabel()
        print(addedDrinksArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addButtonOutlet.layer.cornerRadius = 25
        addButtonOutlet.layer.shadowColor = UIColor.black.cgColor
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButtonOutlet.layer.masksToBounds = false
        addButtonOutlet.layer.shadowRadius = 1.0
        addButtonOutlet.layer.shadowOpacity = 0.5
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.navigationItem.hidesBackButton = true
    
        addedDrinksCollectionView?.delegate = self
        addedDrinksCollectionView?.dataSource = self
        progressBar.maxProgress = maxProgress
        progressBar.progressLayer.strokeEnd = CGFloat(UserSettings.userProgress)
        progress = Float(UserSettings.addedVolume)
        print(progress)
        resetDataEveryNight()
        
        print(progressBar.progressLayer.strokeEnd)
        //обновляем лейбл с результатом кол-ва воды при запуске приложения и сохраняем результат добавленного юзером объема воды
        DispatchQueue.main.async {
            self.resultValue.text = UserSettings.result
            self.volume = UserSettings.addedVolume
            self.defaults.set(self.volume, forKey: String(UserSettings.addedVolume))
            self.currentValue.text = String(UserSettings.addedVolume) + " " + "/"
            self.checkAddedDrinksAndUpdateLabel()
            self.resetDataEveryNight()
            self.setupVisualEffectView()
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //алёрт о том, что дненвная норма выполнена
        /*
         В UserSettings.alert записываем инфу был ли показан алерт. Изначально не показан (false), если был показан, то меняем на true и инфа об этом записывается в UserDefaults. После первого раза алерт не будет показываться */
        func showAlert() {
            if UserSettings.alert == false && progressBar.progressLayer.strokeEnd >= 1.0 {
                UserSettings.alert = true
                //создаем алерт
                let alertController = UIAlertController(title: "Поздравляем!", message: "Вы выполнили свою дневную норму", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                    //в замыкании вызываем функцию, которая по нажатию на кнопку на алерте убирает блюр
                    self.animateOut()
                }))
                //показываем алерт
                present(alertController, animated: true, completion: nil)
                animateIn()
            }
        }
        showAlert()
    }
    
    //создаем блюр эффект
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    //функция включения анимации блюра
    func animateIn() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1.0
        }
    }
    //выключаем блюр
    func animateOut() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 0
        }
    }
    
    func resetDataEveryNight() {
        //сохраняем текущую дату пользователя
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let str = df.string(from: Date())
        print(str)
        if str == UserSettings.userDate {
            return
        } else {
            UserSettings.userDate = str
            currentValue.text = "0"
            resultValue.text = UserSettings.result
            progress = 0
            print(progress)
            UserSettings.userProgress = 0
            volume = 0
            progressBar.progressLayer.strokeEnd = 0
            print(volume)
            addedDrinksArray.removeAll()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {

    }
    
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) {

    }
    
    func updateProgress(with value: Float) {
        progress += value
        print(progress)
        progressBar.updateProgress(with: progress)
    }
    
    //функция для добавления нового выбранного объема напитка
    public func addVolume(_ value: Int) {
        volume += value
    }
    
    public func newDaily(_ value: String) {
        newNormal = value
        print(newNormal)
    }
    
    //обновляем лейбл
    private func updateVolumeLabel(with value: Int) {
        //форматируем и выводим текст в лейбле
        let text = value
        UserSettings.addedVolume = text
        currentValue.text = String(UserSettings.addedVolume) + " " + "/"
        defaults.set(text, forKey: String(UserSettings.addedVolume))
    }
    
    private func updateNewDailyNormal(with value: String) {
        let text = value
        resultValue.text = text
        print(text)
    }
    
    //MARK: - Обновляем лейбл "вы не добавили ни одного напитка" после добавления напитика
    func checkAddedDrinksAndUpdateLabel() {
        if currentValue.text == "0" {
            addedDrinksLabel.text = "Вы не добавили \nни одного напитика"
            self.view.addSubview(addedDrinksLabel)
        } else {
            //обноявлем лейбл добавленными напитками
            let layout = UICollectionViewFlowLayout()
            addedDrinksLabel.isHidden = true
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
            setupVisualEffectView()
            
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
        cell.descriptionDrink.text = addedDrinksArray[indexPath.row]
        
        cell.configure(with: addedDrinksArray[indexPath.row])
        return cell
    }
}








