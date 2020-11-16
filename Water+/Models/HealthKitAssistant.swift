//
//  HealthKitAssistant.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 31.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import HealthKit

class HealthKitSetupAssistant {
  
  private enum HealthkitSetupError: Error {
    case notAvailableOnDevice
    case dataTypeNotAvailable
  }
  
  class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
    //1. Check to see if HealthKit Is Available on this device
    guard HKHealthStore.isHealthDataAvailable() else {
      completion(false, HealthkitSetupError.notAvailableOnDevice)
      return
    }

    //2. Prepare the data types that will interact with HealthKit
    guard
            let height = HKObjectType.quantityType(forIdentifier: .height),
            let water = HKObjectType.quantityType(forIdentifier: .dietaryWater),
            let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass) else {
            
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
    }
    
    //3. Prepare a list of types you want HealthKit to read and write
    let healthKitTypesToWrite: Set<HKSampleType> = [water, height, bodyMass]
        
    let healthKitTypesToRead: Set<HKObjectType> = [height,
                                                   bodyMass,
                                                   water]
    
    //4. Request Authorization
    HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite,
                                         read: healthKitTypesToRead) { (success, error) in
      completion(success, error)
    }

  }
}
