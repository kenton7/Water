//
//  CalculateWater.swift
//  Water+
//
//  Created by Илья Кузнецов on 17.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation

struct CalculateWater {
    
    var water: Water?

    
    func getNormalValueMan() -> String {
        let manToOneDecimalPlace = String(format: "%1.f", K.manDefaultValue)
        return manToOneDecimalPlace
    }
    func getNormalValueWoman() -> String {
        let womanToOneDecimalPlace = String(format: "%1.f", K.womanDefaultValue)
        return womanToOneDecimalPlace
    }
    
    func calculateWaterForMan(weight: Double) -> Double {
        //формула расчета нормы выпитой воды в сутки
        let normalValueMan = weight * K.manDefaultValue
        return normalValueMan
    }
    
    func calculateWaterForWoman(weight: Double) -> Double {
        let normalWaterWoman = weight * K.womanDefaultValue
        return normalWaterWoman
    }
    
    func calculateMediumActivity(weight: Double) -> Double {
        let mediumWater = (weight / 25)
        return mediumWater
    }
    
    func calculateHardActivity(weight: Double) -> Double {
        let hardWater = (weight / 21)
        return hardWater
    }
}

