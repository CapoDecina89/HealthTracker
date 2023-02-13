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
    
    // init instance of ChallengeData by importing "challengeData.json" & request HealthKit authorization
    init() {
        challenges = ChallengeData.loadFromJSON("challengeData.json")
        print("Requesting HealthKit authorization...")
        let readTypes = Set(HealthData.readDataTypes)
        let shareTypes = Set(HealthData.shareDataTypes)
        HealthData.healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error)  in
            if let error = error {
                print("requestAuthorization error:", error.localizedDescription)
            }
            if success {
                print("HealthKit authorization request was successful!")
                //perform the query and update dailyData
                for challenge in self.challenges {
                    self.queryDailyData(for: challenge)
                }
                
            } else {
                print("HealthKit authorization was not successful.")
            }
        }
    }
    
    /// Set and execute a query on the user's healthstore for last 30 days data relevant for the challenges
    func queryDailyData(for challenge: Challenge) {
        
        // Create a 1-day interval.
        let daily = DateComponents(day: 1)
        
        // Set the anchor for 3 a.m. on Monday.
        let anchorDate = createAnchorDate()
        
        let typeIdentifier = HKQuantityTypeIdentifier(rawValue: challenge.typeIdentifier)
        
        guard let quantityType = HKObjectType.quantityType(forIdentifier: typeIdentifier) else {
            fatalError("*** Unable to create a matching quantityType ***")
        }
        
        //How much days to go back in time
        guard let thirtyDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -30), to: Date()) else {
            fatalError("*** Unable to create a date thirty days ago ***")
        }
        
        //predicate for setting the querys timescope
        let oneMonthAgo = HKQuery.predicateForSamples(withStart: thirtyDaysAgo, end: nil, options: .strictStartDate)
        
        // Create the query.
        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: oneMonthAgo,
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
                self.updateDailyData(statsCollection, challenge)
            } else {
                assertionFailure("Handling error")
            }
        }
        HealthData.healthStore.execute(query)
    }
    
    /// processes the HKStatisticsCollection provided by `queryDailyData(for:)` and writes the data to `challenge.dailyData` for each challenge.
    func updateDailyData(_ statsCollection: HKStatisticsCollection, _ challenge: Challenge) {
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
                
                if let quantity = statistics.sumQuantity(),
                   let unit = preferredUnit(for: challenge.typeIdentifier) {
                    dataValue.value = quantity.doubleValue(for: unit)
                }
                // Extract each days data.
                print(dailyData)
                dailyData.append(dataValue)
            }
            self.challenges[challenge.id].dailyData = dailyData
            
            //Umwandlung in Dictionary
            //self.challenges[0].dailyData = Dictionary(dailyData, uniquingKeysWith: { _, last in last})
        }
    }
    
    /// writes `self.challenges` to `challenge.json` in the document directory
    func saveToJSON() {
        
        // Find Documents directory
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: "challengeData.json")
        // Encoder
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let encodedChallenges = try encoder.encode(self.challenges)
            try encodedChallenges.write(to: documentsURL, options: .noFileProtection)
            
        } catch {
            fatalError("Couldn't save Challenges as challengeData.json to Documents Directory:\n\(error)")
        }
    }
    
    /// loads `self.challenges` from filename.json in documents directory or if not existing from bundle
    static func loadFromJSON<T: Decodable>(_ filename: String) -> T {
        let data: Data
        let documentsURL = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first?.appending(path: filename)
        let file: URL
        //look for stored data in documents folder of app's container, if not found, use default in bundle
        if FileManager.default.fileExists(atPath: documentsURL?.relativePath ?? "nil") {
            file = documentsURL!
        } else {
            file = Bundle.main.url(forResource: filename, withExtension: nil)!
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
}
