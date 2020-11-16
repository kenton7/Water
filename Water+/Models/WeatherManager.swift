//
//  WeatherManager.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 26.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=143daa162cf49b2478368082599ec124&units=metric&lang=ru"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    //функция получения координат
    func fetchWeather(latitude: CLLocationDegrees, longitide: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitide)"
        performRequest(with: urlString)
    }

    //создаем запрос
    func performRequest(with urlString: String) {
        // 1. Создаем URL
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " " ) {
            //2. Создаем URL сессию
            let session = URLSession(configuration: .default)
            //3. Даём задачу сессии
            let task = session.dataTask(with: url) { (data, response, error) in
                //ловим ошибку
                 if error != nil {
                    self.delegate?.didFailError(error: error!)
                           return
                       }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        //возвращаем данные о погоде в главный ViewController
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                       }
            }
            //4. Запускаем выполнение задачи
            task.resume()
        }
    }
    
    //парсим JSON
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            //ловим возможную ошибку при парсинге JSON
        } catch {
            delegate?.didFailError(error: error)
            return nil
        }
    }
}

