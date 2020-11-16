//
//  ProfileDataStore.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 31.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import HealthKit

class ProfileDataStore {
    class func getAgeAndSexType() throws -> (age: Int,
                                                  biologicalSex: HKBiologicalSex) {
        
      let healthKitStore = HKHealthStore()
        
      do {

        //1. This method throws an error if these data are not available.
        let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
        let biologicalSex =       try healthKitStore.biologicalSex()
          
        //2. Use Calendar to calculate age.
        let today = Date()
        let calendar = Calendar.current
        let todayDateComponents = calendar.dateComponents([.year],
                                                            from: today)
        let thisYear = todayDateComponents.year!
        let age = thisYear - birthdayComponents.year!
         
        //3. Unwrap the wrappers to get the underlying enum values.
        let unwrappedBiologicalSex = biologicalSex.biologicalSex
          
        return (age, unwrappedBiologicalSex)
      }
    }
    
    class func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
      
    //1. Use HKQuery to load the most recent samples.
    let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                          end: Date(),
                                                          options: .strictEndDate)
        
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                          ascending: false)
        
    let limit = 1
        
    let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                    predicate: mostRecentPredicate,
                                    limit: limit,
                                    sortDescriptors: [sortDescriptor]) { (query, samples, error) in
        
        //2. Always dispatch to the main thread when complete.
        DispatchQueue.main.async {
            
          guard let samples = samples,
                let mostRecentSample = samples.first as? HKQuantitySample else {
                    
                completion(nil, error)
                return
          }
            
          completion(mostRecentSample, nil)
        }
      }
     
    HKHealthStore().execute(sampleQuery)
    }
    
    class func saveWaterSample(water: Double, date: Date) {
      
      //1.  Make sure type exists
      guard let waterIndexType = HKQuantityType.quantityType(forIdentifier: .dietaryWater) else {
        fatalError("Body Mass Index Type is no longer available in HealthKit")
      }
        
      //2.  Use the Liter HKUnit to create a milieter quantity
        let waterQuantity = HKQuantity(unit: HKUnit.literUnit(with: .milli),
                                        doubleValue: water)
        
      let waterIndexSample = HKQuantitySample(type: waterIndexType,
                                                 quantity: waterQuantity,
                                                 start: date,
                                                 end: date)
        
      //3.  Save the same to HealthKit
      HKHealthStore().save(waterIndexSample) { (success, error) in
          
        if let error = error {
          print("Error Saving Water Sample: \(error.localizedDescription)")
        } else {
          print("Water Sample successfully saved")
        }
      }
    }

}

