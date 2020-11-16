//
//  Establishment.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 08.11.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import CloudKit

class Establishment {
    enum UserData: Int {
        case none
        case currentValue
        case dailyRate
        case weight
    }
    let gender: String
    static let recordType = "Establishment"
    private let id: CKRecord.ID
    let userData: UserData
    let database: CKDatabase
    
    init?(record: CKRecord, database: CKDatabase) {
        guard
            let gender = record["gender"] as? String else { return nil }
        id = record.recordID
        self.gender = gender
        self.database = database
        if let userDataValue = record["userData"] as? Int,
           let userData = UserData(rawValue: userDataValue) {
            self.userData = userData
        } else {
            self.userData = .none
        }
    }
}

extension Establishment: Hashable {
  static func == (lhs: Establishment, rhs: Establishment) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

