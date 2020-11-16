//
//  ChartsVC.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 18.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit
import Foundation
import Charts

class ChartsViewController: UIViewController, ChartViewDelegate {
    
    let daysArray = ["Пнд", "Вт", "Ср", "Чт", "Пт", "Сб", "Вск"]
    let result = [UserSettings.monday ?? 0.0, UserSettings.tuesday ?? 0.0, UserSettings.wednesday ?? 0.0, UserSettings.thursday ?? 0.0, UserSettings.friday ?? 0.0, UserSettings.saturday ?? 0.0, UserSettings.sunday ?? 0.0]
    //let result = [UserSettings.monday ?? 0.0, UserSettings.tuesday ?? 0.0, UserSettings.wednesday ?? 0.0, UserSettings.thursday ?? 0.0, UserSettings.friday ?? 0.0, UserSettings.saturday ?? 0.0, UserSettings.sunday ?? 0.0]
    var dataEntries: [BarChartDataEntry] = []
    let milileters = MililetersViewController()
    var currentCount = 0.0
    var step: Double = 0.0
    let today = Date()

    @IBOutlet weak var chartsView: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartsView.delegate = self
        setChart(dataPoints: daysArray, values: result)
        //updatePieChartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
        tabBarController?.navigationItem.title = NSLocalizedString("STATISTIC", comment: "stat")
        //chartsView.setNeedsDisplay()
            setChart(dataPoints: daysArray, values: result)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setChart(dataPoints: daysArray, values: result)
    }
    
    
    private func setChart(dataPoints: [String], values: [Double]) {
        
        chartsView.noDataText = NSLocalizedString("CHART_NO_DATA_TEXT", comment: "no data")
        let xAxis=XAxis()
        let chartFormmater=ChartXAxisFormatter()

        for i in 0..<daysArray.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            //chartFormmater.stringForValue(Double(i), axis: xAxis)
            xAxis.valueFormatter=chartFormmater
            chartsView.xAxis.valueFormatter=xAxis.valueFormatter
            
            dataEntries.append(dataEntry)
        }
                
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.setColor(.tertiarySystemBackground)
        let data = BarChartData(dataSet: chartDataSet)
        chartsView.data = data
        //chartsView.xAxis.valueFormatter = ChartXAxisFormatter()
        
        chartDataSet.colors = ChartColorTemplates.joyful()
        //chartDataSet.colors = ChartColorTemplates.colorful()
        chartsView.xAxis.labelPosition = .bottom
        chartsView.xAxis.labelTextColor = .systemGray
        chartsView.backgroundColor = .tertiarySystemBackground
        
        chartsView.barData?.setValueTextColor(.systemGray)
        chartsView.noDataTextColor = .systemGray
        chartsView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        let ll = ChartLimitLine(limit: 100.0, label: NSLocalizedString("MAX_CHART", comment: "max"))
        chartsView.rightAxis.addLimitLine(ll)
        
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
        
        _ = formatter.string(from: Date()).capitalized
        
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
        
        _ = StatisticScreen(showNumber: NSLocalizedString("MONDAY", comment: "Mnd"), viewCount: UserSettings.monday)
        _ = StatisticScreen(showNumber: NSLocalizedString("TUESDAY", comment: "tsd"), viewCount: UserSettings.tuesday)
        _ = StatisticScreen(showNumber: NSLocalizedString("WEDNESDAY", comment: "Wdn"), viewCount: UserSettings.wednesday)
        _ = StatisticScreen(showNumber: NSLocalizedString("THURSDAY", comment: "Tsd"), viewCount: UserSettings.thursday)
        _ = StatisticScreen(showNumber: NSLocalizedString("FRIDAY", comment: "fr"), viewCount: UserSettings.friday)
        _ = StatisticScreen(showNumber: NSLocalizedString("SATURDAY", comment: "Str"), viewCount: UserSettings.saturday)
        _ = StatisticScreen(showNumber: NSLocalizedString("SUNDAY", comment: "Snd"), viewCount: UserSettings.sunday)
        
        chartsView.notifyDataSetChanged()
        
    }
    
    
    
//    private func updatePieChartData() {
//        let chartDataSet = PieChartDataSet(entries: dataPieChartEntry)
//        let chartData = PieChartData(dataSet: chartDataSet)
//
//        //let colors = [UIColor.blue]
//        chartDataSet.setColor(.blue)
//        //pieChartView.data = chartData
//
//    }
    
//    func updateValueInPieChart() {
//        waterPlus += UserDefaults.standard.double(forKey: "waterCount")
//    }
//    
//    public func plusWater(_ value: Double) {
//        waterPlus += value
//    }
}

class ChartXAxisFormatter: NSObject, IAxisValueFormatter {
    
    let daysArray = ["Пнд", "Вт", "Ср", "Чт", "Пт", "Сб", "Вск"]

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        return daysArray[Int(value)]
    }
}

