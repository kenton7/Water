//
//  SettingsScreen.swift
//  Water+
//
//  Created by Илья Кузнецов on 03.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSections: Int, CaseIterable, CustomStringConvertible {
    
    case General
    //case Customization
    case About
    
    var description: String {
        switch self {
        case .General:
            return NSLocalizedString("GENERAL", comment: "general")
//        case .Customization:
//            return "Оформление"
        case .About:
            return NSLocalizedString("OTHER", comment: "other")
        }
    }
}

enum GeneralOptions: Int, CaseIterable, SectionType {
    var containsSwitch: Bool { return false }
    
    case normalDaily
    case changeWeight
    case notifications
    case language
    case darkTheme
    
    var description: String {
        switch self {
        case .normalDaily:
            return "Дневная норма"
        case .changeWeight:
            return "Изменить вес"
        case .darkTheme:
            return "Тёмная тема"
        case .notifications:
            return "Уведомления"
        case .language:
            return "Язык"
        }
    }
}

//enum CustomizationOptions: Int, CaseIterable, CustomStringConvertible {
//
//    case darkTheme
//
//    var description: String {
//        switch self {
//        case .darkTheme:
//            return "Тёмная тема"
//        }
//    }
//}

enum AboutOptions: Int, CaseIterable, SectionType {
    var containsSwitch: Bool { return false }
    
    //case rateApp
    case writeToSupport
    case aboutAppllication
    case infoAboutDrinks
    case siriShortcuts
    
    var description: String {
        switch self {
        case .aboutAppllication:
            return "О приложении"
        case .infoAboutDrinks:
            return "Информация о напитках"
        //case .rateApp:
            //return "Оценить приложение"
        case .siriShortcuts:
            return "Настроить Siri Shortcuts"
        case .writeToSupport:
            return "Написать разработчикам"
            
        }
    }
}
