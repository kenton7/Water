//
//  MacawChartView.swift
//  Water+
//
//  Created by Илья Кузнецов on 04.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import Macaw

class MacawCharts: MacawView {
    
    static let daysOfWeek = createDummyData()
    static let maxValue = 100
    static let maxValueLineHeight = 100
    static let lineWidth: Double = 350
    static let dataDivisor = Double(maxValue / maxValueLineHeight)
    static let adjustedData: [Double] = daysOfWeek.map({ $0.viewCount / dataDivisor })
    static var animations: [Animation] = []
    
    
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
    
    private static func createBars() -> Group {
        
        let fill = LinearGradient(degree: 90, from: Color.blue, to: Color.blue.with(a: 0.33))
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
    
    private static func createDummyData() -> [StatisticScreen] {
        let monday = StatisticScreen(showNumber: "Пн", viewCount: 40)
        let tuesday = StatisticScreen(showNumber: "Вт", viewCount: 70)
        let wednesday = StatisticScreen(showNumber: "Ср", viewCount: 64)
        let thursday = StatisticScreen(showNumber: "Чт", viewCount: 100)
        let friday = StatisticScreen(showNumber: "Пт", viewCount: 77)
        let suturday = StatisticScreen(showNumber: "Сб", viewCount: 80)
        let sunday = StatisticScreen(showNumber: "Вск", viewCount: 89)
        
        return [monday, tuesday, wednesday, thursday, friday, suturday, sunday]
    }
}
