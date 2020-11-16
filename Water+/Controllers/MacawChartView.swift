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
    
    static var daysOfWeek = chartsData()
    static let maxValue = 100
    static let maxValueLineHeight = 100
    static let lineWidth: Double = 350
    static let dataDivisor = Double(maxValue / maxValueLineHeight)
    static var adjustedData: [Double] = daysOfWeek.map({ $0.viewCount / dataDivisor })
    static var animations: [Animation] = []
    var resultOfDay: Double = 0
    var currentDay: String?
    let delegate = MainViewController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: MacawCharts.createChart(), coder: aDecoder)
    }
    
    private static func createChart() -> Group {
        var items: [Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())
        return Group(contents: items, place: .identity)
    }
    
    //фукнция обновления инфы
    public func updateData(newData : [StatisticScreen]) {
        MacawCharts.daysOfWeek = newData
        updateDisplay()
    }
    
    //функция для обновления чарта с новыми данными без перезапуска приложения
    public func updateDisplay() {
        let chart = MacawCharts.createChart()
        self.node = Group(contents: [chart])
        MacawCharts.adjustedData = MacawCharts.daysOfWeek.map({$0.viewCount / MacawCharts.dataDivisor})
    }
    
    private static func addYAxisItems() -> [Node] {
        let maxLines = 5
        let lineInterval = Int(maxValue / maxLines)
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 40
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.gray.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.gray
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.gray.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes
    }
    
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        
        for i in 1...adjustedData.count {
            let x = (Double(i) * 50)
            let valueText = Text(text: daysOfWeek[i - 1].showNumber, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.gray
            newNodes.append(valueText)
        }
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.gray.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        currentDay = dateFormatter.string(from: Date()).capitalized
        let percentOfResult = (UserSettings.addedVolume * 100) / delegate.maxProgress!
        resultOfDay = Double(percentOfResult)
        //print(percentOfResult)
        return dateFormatter.string(from: Date()).capitalized
    }
    
    private static func createBars() -> Group {
        
        let fill = LinearGradient(degree: 90, from: .blue, to: .aqua)
        let items = adjustedData.map { _ in Group() }
        
        animations = items.enumerated().map {(i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
                var height = adjustedData[i] * t * 2
                print(height)
                if height > 200 {
                    height = 200
                }
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
        var currentDay: String?
        let delegate = MainViewController()
        let dateFormatter = DateFormatter()
        var monday: Double?
        var tuesday: Double?
        var wednesday: Double?
        var thursday: Double?
        var friday: Double?
        var saturday: Double?
        var sunday: Double?
        let formatter = DateFormatter()
        let date = Date()
        
        dateFormatter.dateFormat = "EEEE"
        formatter.dateFormat = "MM-dd"
        _ = formatter.string(from: date)
        currentDay = dateFormatter.string(from: Date()).capitalized
        print(currentDay!)
        let percentOfResult = (UserSettings.addedVolume * 100) / delegate.maxProgress!
        //print(percentOfResult)
        
        let dayAndMonth = formatter.string(from: Date()).capitalized
        
        switch currentDay {
        case "Monday", "Понедельник", "Lunedi", "Lundi", "Montag":
            monday = Double(percentOfResult)
            UserSettings.monday = monday
        case "Tuesday", "Вторник", "Martedì", "Mardi", "Dienstag":
            tuesday = Double(percentOfResult)
            UserSettings.tuesday = tuesday
        case "Wednesday", "Среда", "Mercoledì", "Mercredi", "Mittwoch":
            wednesday = Double(percentOfResult)
            UserSettings.wednesday = wednesday
        case "Thursday", "Четверг", "Giovedi", "Jeudi", "Donnerstag":
            thursday = Double(percentOfResult)
            UserSettings.thursday = thursday
        case "Friday", "Пятница", "Venerdì", "Vendredi", "Freitag":
            friday = Double(percentOfResult)
            UserSettings.friday = friday
        case "Saturday", "Суббота", "Sabato", "Samedi", "Samstag":
            saturday = Double(percentOfResult)
            UserSettings.saturday = saturday
        case "Sunday", "Воскресенье", "Domenica", "Dimanche", "Sonntag":
            sunday = Double(percentOfResult)
            UserSettings.sunday = sunday
        default:
            break
        }
        
        let mondayForChart = StatisticScreen(showNumber: NSLocalizedString("MONDAY", comment: "Mnd"), viewCount: UserSettings.monday)
        let tuesdayForChart = StatisticScreen(showNumber: NSLocalizedString("TUESDAY", comment: "tsd"), viewCount: UserSettings.tuesday)
        let wednesdayForChart = StatisticScreen(showNumber: NSLocalizedString("WEDNESDAY", comment: "Wdn"), viewCount: UserSettings.wednesday)
        let thursdayForChart = StatisticScreen(showNumber: NSLocalizedString("THURSDAY", comment: "Tsd"), viewCount: UserSettings.thursday)
        let fridayForChart = StatisticScreen(showNumber: NSLocalizedString("FRIDAY", comment: "fr"), viewCount: UserSettings.friday)
        let saturdayForChart = StatisticScreen(showNumber: NSLocalizedString("SATURDAY", comment: "Str"), viewCount: UserSettings.saturday)
        let sundayForChart = StatisticScreen(showNumber: NSLocalizedString("SUNDAY", comment: "Snd"), viewCount: UserSettings.sunday)
        
        
        return [mondayForChart, tuesdayForChart, wednesdayForChart, thursdayForChart, fridayForChart, saturdayForChart, sundayForChart]
    }
}






