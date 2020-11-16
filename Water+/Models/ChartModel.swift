//
//  ChartModel.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 31.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation


struct ChartModel {
        let result = [UserSettings.monday ?? 0.0, UserSettings.tuesday ?? 0.0, UserSettings.wednesday ?? 0.0, UserSettings.thursday ?? 0.0, UserSettings.friday ?? 0.0, UserSettings.saturday!, UserSettings.sunday ?? 0.0]
    var date=Date()
}
