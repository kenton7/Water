//
//  CloudModel.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 08.11.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import CloudKit

class CloudModel {
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    private(set) var establishments: [Establishment] = []
    static var currentModel = CloudModel()
    
    init() {
      container = CKContainer.default()
      publicDB = container.publicCloudDatabase
      privateDB = container.privateCloudDatabase
    }
    
    @objc func refresh(_ completion: @escaping (Error?) -> Void) {
      // 1.
      let predicate = NSPredicate(value: true)
      // 2.
      let query = CKQuery(recordType: "Establishment", predicate: predicate)
      establishments(forQuery: query, completion)
    }

    private func establishments(forQuery query: CKQuery,
        _ completion: @escaping (Error?) -> Void) {
      publicDB.perform(query,
          inZoneWith: CKRecordZone.default().zoneID) { [weak self] results, error in
        guard let self = self else { return }
        if let error = error {
          DispatchQueue.main.async {
            completion(error)
          }
          return
        }
        guard let results = results else { return }
        self.establishments = results.compactMap {
          Establishment(record: $0, database: self.publicDB)
        }
        DispatchQueue.main.async {
          completion(nil)
        }
      }
    }

}
