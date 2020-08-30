//
//  MacawChartView.swift
//  Water+
//
//  Created by Илья Кузнецов on 04.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import UIKit
import Macaw

class MacawCharts: MacawView {
    
    static let daysOfWeek = chartsData()
    static let maxValue = 100
    static let maxValueLineHeight = 100
    static let lineWidth: Double = 350
    static let dataDivisor = Double(maxValue / maxValueLineHeight)
    static let adjustedData: [Double] = daysOfWeek.map({ $0.viewCount / dataDivisor })
    //static let data: [Double] = daysOfWeek.map({$0.resultOfDay / dataDivisor})
    static var animations: [Animation] = []
    var resultOfDay: Double = 0
    var currentDay: String?
    let delegate = MainViewController()
    static var thursday: Double = 0
    
    
    
    
        required init?(coder aDecoder: NSCoder) {
            super.init(node: MacawCharts.createChart(), coder: aDecoder)
    }
    
    private static func createChart() -> Group {
        var items: [Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())
        return Group(contents: items, place: .identity)
    }
    
    private static func addYAxisItems() -> [Node] {
        let maxLines = 5
        let lineInterval = Int(maxValue / maxLines)
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 40
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.black.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.black
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
        let yAxis = Line(x1: 0, y1: -10, x2: 0, y2: yAxisHeight).stroke(fill: Color.black.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes
    }
    
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        
        for i in 1...adjustedData.count {
            let x = (Double(i) * 50)
            let valueText = Text(text: daysOfWeek[i - 1].showNumber, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.black
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth + 10, y2: chartBaseY).stroke(fill: Color.black.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        currentDay = dateFormatter.string(from: Date()).capitalized
        print(currentDay!)
        //let percentOfResult = Double(Float(UserSettings.addedVolume * 100) / delegate.maxProgress!)
        //let percentOfResult = Double(Float(UserSettings.addedVolume * 100) / delegate.maxProgress)
        let percentOfResult = (UserSettings.addedVolume * 100) / delegate.maxProgress!
        resultOfDay = Double(percentOfResult)
        print(percentOfResult)
        return dateFormatter.string(from: Date()).capitalized
    }
    
    private static func createBars() -> Group {
        
        let fill = LinearGradient(degree: 90, from: .blue, to: .aqua)
        //let fill = LinearGradient(degree: 90, from: Color.blue, to: Color.blue.with(a: 0.33))
        let items = adjustedData.map { _ in Group() }
        
        animations = items.enumerated().map {(i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
                let height = adjustedData[i] * t * 2
                let rect = Rect(x: Double(i) * 50 + 25, y: 200 - height, w: 25, h: height)
                return [rect.fill(with: fill)]
            }
        }
        return items.group()
    }
    
    
    
    static func playAnimations() {
        animations.combine().play()
    }
    
    static func chartsData() -> [StatisticScreen] {
        //var resultOfDay: Double = 0
        var currentDay: String?
        let delegate = MainViewController()
        let dateFormatter = DateFormatter()
        var monday: Double?
        var tuesday: Double?
        var wednesday: Double?
        //var thursday: Double?
        var friday: Double?
        var saturday: Double?
        var sunday: Double?
        
        
        dateFormatter.dateFormat = "EEEE"
        currentDay = dateFormatter.string(from: Date()).capitalized
        print(currentDay!)
        //let percentOfResult = Double(Float(UserSettings.addedVolume * 100) / delegate.maxProgress!)
//        let percentOfResult = Double(Float(UserSettings.addedVolume * 100) / delegate.maxProgress)
        let percentOfResult = (UserSettings.addedVolume * 100) / delegate.maxProgress!
        //resultOfDay = percentOfResult
        print(percentOfResult)
        
        switch currentDay {
        case "Monday", "Понедельник":
            monday = Double(percentOfResult)
            UserSettings.monday = monday
        case "Tuesday", "Вторник":
            tuesday = Double(percentOfResult)
            UserSettings.tuesday = tuesday
        case "Wednesday", "Среда":
            wednesday = Double(percentOfResult)
            UserSettings.wednesday = wednesday
        case "Thursday", "Четверг":
            thursday = Double(percentOfResult)
            UserSettings.thursday = thursday
        case "Пятница", "Friday", "Vendredi":
            friday = Double(percentOfResult)
            UserSettings.friday = friday
        case "Saturday", "Суббота":
            saturday = Double(percentOfResult)
            UserSettings.saturday = saturday
        case "Sunday", "Воскресенье":
            sunday = Double(percentOfResult)
            UserSettings.sunday = sunday
        default:
            break
        }
        

        let mondayForChart = StatisticScreen(showNumber: "Пн", viewCount: UserSettings.monday)
        let tuesdayForChart = StatisticScreen(showNumber: "Вт", viewCount: UserSettings.tuesday)
        let wednesdayForChart = StatisticScreen(showNumber: "Ср", viewCount: UserSettings.wednesday)
        let thursdayForChart = StatisticScreen(showNumber: "Чт", viewCount: UserSettings.thursday)
        let fridayForChart = StatisticScreen(showNumber: "Пт", viewCount: UserSettings.friday)
        let saturdayForChart = StatisticScreen(showNumber: "Сб", viewCount: UserSettings.saturday)
        let sundayForChart = StatisticScreen(showNumber: "Вск", viewCount: UserSettings.sunday)
        
        
        return [mondayForChart, tuesdayForChart, wednesdayForChart, thursdayForChart, fridayForChart, saturdayForChart, sundayForChart]
    }
}






