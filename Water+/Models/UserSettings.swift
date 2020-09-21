//
//  UserSettings.swift
//  Water+
//
//  Created by Илья Кузнецов on 23.05.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation

final class UserSettings {
    enum SettingsKeys: String {
        case userSex
        case userWeight
        case userActivity
        case result
        case addedVolume
        case userDate
        case userProgress
        case savingPercentDailyResult
        case alert
        
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        case userNotifFrom
        case userNotifTo
        case userIntervalNotif
    }
    
    static var userSex: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userSex.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userSex.rawValue
            if let sex = newValue {
                print("Пол \(sex) добавлен в \(key)")
                defaults.set(sex, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userWeight: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userWeight.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userWeight.rawValue
            if let weight = newValue {
                print("Вес \(weight) добавлен в \(key)")
                defaults.set(weight, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userActivity: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userActivity.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userActivity.rawValue
            if let activity = newValue {
                print(" Экран активности \(activity) показан, \(key)")
                defaults.set(activity, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var result: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.result.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.result.rawValue
            if let userResult = newValue {
                print("Результат \(userResult) добавлен в \(key)")
                defaults.set(userResult, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var addedVolume: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.addedVolume.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.addedVolume.rawValue
            if let userAddVolume = newValue {
                print("Объем напитка \(userAddVolume) добавлен в \(key)")
                defaults.set(userAddVolume, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userDate: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userDate.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userDate.rawValue
            if let userDate = newValue {
                print("Дата пользователя \(userDate) добавлена в \(key)")
                defaults.set(userDate, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    static var userProgress: Float! {
        get {
            return UserDefaults.standard.float(forKey: SettingsKeys.userProgress.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userProgress.rawValue
            if let userProgress = newValue {
                print("Прогресс пользователя \(userProgress) добавлен в \(key)")
                defaults.set(userProgress, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var monday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.monday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.monday.rawValue
            if let monday = newValue {
                print("Результат в процентах \(monday) добавлен в \(key)")
                defaults.set(monday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var tuesday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.tuesday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.tuesday.rawValue
            if let tuesday = newValue {
                print("Результат в процентах \(tuesday) добавлен в \(key)")
                defaults.set(tuesday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var wednesday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.wednesday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.wednesday.rawValue
            if let wednesday = newValue {
                print("Результат в процентах \(wednesday) добавлен в \(key)")
                defaults.set(wednesday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var thursday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.thursday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.thursday.rawValue
            if let thursday = newValue {
                print("Результат в процентах \(thursday) добавлен в \(key)")
                defaults.set(thursday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var friday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.friday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.friday.rawValue
            if let friday = newValue {
                print("Результат в процентах \(friday) добавлен в \(key)")
                defaults.set(friday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var saturday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.saturday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.saturday.rawValue
            if let saturday = newValue {
                print("Результат субботы \(saturday) добавлен в \(key)")
                defaults.set(saturday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var sunday: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingsKeys.sunday.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.sunday.rawValue
            if let sunday = newValue {
                print("Результат в процентах \(sunday) добавлен в \(key)")
                defaults.set(sunday, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var alert: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: SettingsKeys.alert.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.alert.rawValue
            if let alert = newValue {
                print("Алерт показан: \(alert). Данные записаны в \(key)")
                defaults.set(alert, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userNotifFrom: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userNotifFrom.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userNotifFrom.rawValue
            if let userNotifFrom = newValue {
                print("Дата начала отправки уведомлений \(userNotifFrom) добавлена в \(key)")
                defaults.set(userNotifFrom, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userNotifTo: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userNotifTo.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userNotifTo.rawValue
            if let userNotifTo = newValue {
                print("Дата начала отправки уведомлений \(userNotifTo) добавлена в \(key)")
                defaults.set(userNotifTo, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userIntervalNotif: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.userIntervalNotif.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userIntervalNotif.rawValue
            if let userIntervalNotif = newValue {
                print("Дата начала отправки уведомлений \(userIntervalNotif) добавлена в \(key)")
                defaults.set(userIntervalNotif, forKey: key)
                UserDefaults.standard.synchronize()
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
}




