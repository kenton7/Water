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
        case result
        case addedVolume
        case userDate
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
    
    static var result: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.result.rawValue)
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
}


