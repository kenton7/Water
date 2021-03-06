//
//  MainViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 18.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //var maxProgress = Float(UserSettings.result) ?? 0
    //var maxProgress = 0
    var maxProgress = UserSettings.result
    
    private var progress: Float = 0
    var progress2: Float = 0
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
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
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
    
    //@IBOutlet weak var addedDrinksLabel: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = NSLocalizedString("MAIN", comment: "main")
        checkAddedDrinksAndUpdateLabel()
        print(addedDrinksArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //запрашиваем разрешение на использование геопозиции
        //locationManager.requestWhenInUseAuthorization()
        //после разрешения использования геопозиции, делаем запрос на определение геопопзции
        locationManager.requestLocation()
        weatherManager.delegate = self
        print(UserSettings.result!)
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
        progressBar.maxProgress = Float(UserSettings.result)
        progressBar.progressLayer.strokeEnd = CGFloat(UserSettings.userProgress)
        progressBar.backgroundColor = .tertiarySystemBackground
        if progressBar.progressLayer.strokeEnd >= 1.0 {
            progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        }
        progress = Float(UserSettings.addedVolume)
        resetDataEveryNight()
        
        print(progressBar.progressLayer.strokeEnd)
        //обновляем лейбл с результатом кол-ва воды при запуске приложения и сохраняем результат добавленного юзером объема воды
        DispatchQueue.main.async {
            self.resultValue.text = String(UserSettings.result)
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
                    self.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
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
            resultValue.text = String(UserSettings.result)
            progress = 0
            print(progress)
            UserSettings.userProgress = 0
            volume = 0
            progressBar.progressLayer.strokeEnd = 0
            print(volume)
            addedDrinksArray.removeAll()
            UserSettings.alert = false
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
        let floatNewValue = Int(newNormal)
        progress = Float(UserSettings.addedVolume)
        let result = progress / Float(floatNewValue!)
        UserSettings.userProgress = result
        DispatchQueue.main.async {
            self.progressBar.progressLayer.strokeEnd = CGFloat(result)
        }
        print(progress)
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
            //addedDrinksLabel.text = "Вы не добавили \nни одного напитика"
            //self.view.addSubview(addedDrinksLabel)
        } else {
            //обноявлем лейбл добавленными напитками
            let layout = UICollectionViewFlowLayout()
            //addedDrinksLabel.isHidden = true
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 80, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            addedDrinksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            addedDrinksCollectionView?.showsHorizontalScrollIndicator = false
            addedDrinksCollectionView?.delegate = self
            addedDrinksCollectionView?.dataSource = self
            addedDrinksCollectionView?.backgroundColor = .tertiarySystemBackground
            addedDrinksCollectionView?.register(AddedDrinksCollectionViewCell.self, forCellWithReuseIdentifier: K.identifierAddedDrinksCollectionView)
            guard let collectionViewDrinks = addedDrinksCollectionView else { return }
            UserDefaults.standard.set(addedDrinksArray, forKey: "savedArray")
            view.addSubview(collectionViewDrinks)
            setupVisualEffectView()
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addedDrinksCollectionView?.frame = CGRect(x: 0, y: 95, width: view.frame.size.width, height: 80)
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

extension MainViewController: WeatherManagerDelegate {
    //берем данные о погоде из WetherModel
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //помещаем температуру в соответствубщий лейбл
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            
            if UserDefaults.standard.bool(forKey: "updatedWithSummerWeather") == true {
                return
            } else {
                if weather.temperature >= 25.0 {
                    let summerResult = Double(UserSettings.result) * 1.5
                    let summerResultInt = Int(summerResult)
                    UserSettings.result = summerResultInt
                    if self.progressBar.progressLayer.strokeEnd >= 1.0 {
                        self.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    } else {
                        self.progressBar.progressLayer.strokeColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
                    }
                    self.newDaily(self.resultValue.text!)
                    self.resultValue.text = String(summerResultInt)
                    UserDefaults.standard.setValue(true, forKey: "updatedWithSummerWeather")
                } else {
                    return
                }
            }
            print("--------------")
            print(weather.conditionID)
            print("------------------")
        }
    }
    //функция для отлавливания ошибок
    func didFailError(error: Error) {
        print(error)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //запрашиваем координаты
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitide: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}








