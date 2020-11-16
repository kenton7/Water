//
//  ViewController.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomeViewController: UIViewController {
    
    var calculateWater = CalculateWater()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    
    //скрываем nav bar на первом view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    //показываем navigation bar на остальных view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //запрашиваем доступ к геолокации пользователя при первом включении приложения
        locationManager.requestWhenInUseAuthorization()
        //после разрешения использования геопозиции, делаем запрос на определение геопопзции
        //locationManager.requestLocation()

        
        if UserDefaults.standard.bool(forKey: "ManSelected") {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(identifier: "WeightManVC")
            navigationController?.pushViewController(mainViewController, animated: false)
        }
        
        if UserDefaults.standard.bool(forKey: "WomanSelected") {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(identifier: "WeightWomanVC")
            navigationController?.pushViewController(mainViewController, animated: false)
        }
    }

    @IBAction func manSelected(_ sender: UIButton) {
        UserSettings.userSex = "ManSelected"
        UserDefaults.standard.set(true, forKey: "ManSelected")
    }
    
    @IBAction func womanSelected(_ sender: UIButton) {
        UserSettings.userSex = "WomanSelected"
        UserDefaults.standard.set(true, forKey: "WomanSelected")
    }
}

extension WelcomeViewController: CLLocationManagerDelegate {
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

