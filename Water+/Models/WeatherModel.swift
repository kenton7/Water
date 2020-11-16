//
//  WeatherModel.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 26.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    //вычисляемое свойство (computed property)
    var conditionName: String {
        //иконка в заисимости от погодных условий
        switch conditionID {
             case 200...232:
                 return "cloud_bolt"
             case 300...321:
                 return "cloud_drizzle"
             case 500...531:
                 return "cloud_rain"
             case 600...622:
                 return "cloud_snow"
             case 701...781:
                 return "cloud_fog"
             case 800:
                 return "sun_max"
             case 801...804:
                 return "cloudDefault"
             default:
                 return "cloudDefault"
             }
    }
}
