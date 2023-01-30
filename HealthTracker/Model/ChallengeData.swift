//
//  ModelData.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 19.01.23.
//

import Foundation
import Combine
import HealthKit

// Neuer Ansatz

final class ChallengeData: ObservableObject {
    //Array mit allen Daten der Challenges
    @Published var challenges: [Challenge]
    
    let healthStore = HealthData.healthStore
    
    init() {
        challenges = load("challengeData.json")
        let readTypes = Set(HealthData.readDataTypes)
        let shareTypes = Set(HealthData.shareDataTypes)
    
        print("Requesting HealthKit authorization...")
        self.healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error)  in
            if let error = error {
                print("requestAuthorization error:", error.localizedDescription)
            }
            if success {
                print("HealthKit authorization request was successful!")
                //perform the query and update dailyData
                self.queryDailyData()
            } else {
                print("HealthKit authorization was not successful.")
            }
        }
        
    }
    
    func queryDailyData() {
        
        // Create a 1-day interval.
        let daily = DateComponents(day: 1)
        
        // Set the anchor for 3 a.m. on Monday.
        let anchorDate = createAnchorDate()
        
        guard let quantityType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("*** Unable to create a step count type ***")
        }
        
        //How much days to go back in time
        //guard let thirtyDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date()) else {
          //  fatalError("*** Unable to create a date thirty days ago ***")
        //}
        
        //predicate for setting the querys timescope
        //let oneMonthAgo = HKQuery.predicateForSamples(withStart: thirtyDaysAgo, end: nil, options: .strictStartDate)
        
        // Create the query.
        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: nil,//oneMonthAgo,
                                                options: .cumulativeSum,
                                                anchorDate: anchorDate,
                                                intervalComponents: daily)
        
        // Set the results handler.
        query.initialResultsHandler = { query, results, error in
            
            // Handle errors here.
            if let error = error as? HKError {
                switch (error.code) {
                case .errorDatabaseInaccessible:
                    print("HealthKit couldn't access the database because the device is locked.")
                    return
                default:
                    print("other HealthKit errors.")
                    return
                }
            }
            
            if let statsCollection = results {
                self.updateDailyData(statsCollection)
            } else {
                assertionFailure("Handling error")
            }
        }
        healthStore.execute(query)
        
    }
    
    func updateDailyData(_ statsCollection: HKStatisticsCollection) {
        DispatchQueue.main.async {
            // Array for plotting the data
            var dailyData: [DailyData] = []

            //Set startDate
            guard let startDate = Calendar.current.date(byAdding: DateComponents(day: -30), to: Date()) else {
                fatalError("*** Unable to create a date thirty days ago ***")
            }
                let endDate = Date()
                    
            // Enumerate over all the statistics objects between the start and end dates.
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                var dataValue = DailyData(date: statistics.startDate,
                                          value: 0)
                if let quantity = statistics.sumQuantity() {
                    dataValue.value = quantity.doubleValue(for: .count())
                }
                // Extract each days data.
                dailyData.append(dataValue)
            }
            //for schleife für alle Challenges erstellen
            self.challenges[0].dailyData = dailyData
            
            //Umwandlung in Dictionary
            //self.challenges[0].dailyData = Dictionary(dailyData, uniquingKeysWith: { _, last in last})
        }
        
    }
    
            
     /*   // Create a query for each data type.
        for challenge in challenges {
            // Set dates
            let now = Date()
            let startDate = getLastWeekStartDate()
            let endDate = now
            
            let predicate = createLastWeekPredicate()
            let dateInterval = DateComponents(day: 1)
            
            // Process data.
            let statisticsOptions = getStatisticsOptions(for: challenge.dataType)
            let initialResultsHandler: (HKStatisticsCollection) -> Void = { (statisticsCollection) in
                var dailyData: [Date: Double] = [:]
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                    let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                    if let unit = preferredUnit(for: challenge.dataType),
                        let value = statisticsQuantity?.doubleValue(for: unit) {
                        dailyData.append(value)
                    }
                }
                
                self.challenges[challenge.id].dailyData = dailyData
                
                completion()
            }
            
            // Fetch statistics.
            HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: challenge.dataType),
                                       predicate: predicate,
                                       options: statisticsOptions,
                                       startDate: startDate,
                                       interval: dateInterval,
                                       completion: initialResultsHandler)
        }
    }*/
}

    /*static*/ func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    

    /*
     //Überarbeiten
     func save(to filename: String) {
            
        let encoder = JSONEncoder()
        do {
            let encodedChallenges = try encoder.encode(challenges)
            try encodedChallenges.write(to: Bundle.main.bundleURL.appendingPathComponent("challengeData").appendingPathExtension(for: .json), options: .noFileProtection)
            
        } catch {
            fatalError("Couldn't save Challenges as \(filename):\n\(error)")
        }
    }*/
/*
// Alter Ansatz

//Array mit allen Daten der Challenges
var challenges: [Challenge] = load("challengeDataNew.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func save(to filename: String) {
        
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    do {
        let encodedChallenges = try encoder.encode(challenges)
        try encodedChallenges.write(to: Bundle.main.bundleURL.appendingPathComponent(filename).appendingPathExtension(for: .json), options: .noFileProtection)
        
    } catch {
        fatalError("Couldn't save Challenges as \(filename):\n\(error)")
    }
}
*/
