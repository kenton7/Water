//
//  StatisticScreen.swift
//  Water+
//
//  Created by Илья Кузнецов on 04.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import  UIKit

struct StatisticScreen {
    var showNumber: String
    var viewCount: Double
}

struct DataCharts {
    var resultOfDay: Double = 0
    var currentDay: String?
    let delegate = MainViewController()
    
    mutating func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        currentDay = dateFormatter.string(from: Date()).capitalized
        print(currentDay!)
        let percentOfResult = (UserSettings.addedVolume * 100) / delegate.maxProgress!
        resultOfDay = Double(percentOfResult)
        print(percentOfResult)
        return dateFormatter.string(from: Date()).capitalized
    }
    
}


