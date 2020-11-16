//
//  WeatherData.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 26.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation

//структура всего парсинга JSON
//из самого JSON берем необходимые поля

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
