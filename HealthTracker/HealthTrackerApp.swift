//
//  HealthTrackerApp.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 14.01.23.
//

import SwiftUI
import HealthKit

@main
struct HealthTrackerApp: App {
    //Ansatz Instanz von ChallengeData wir zum Start aus json geladen
    @StateObject private var challengeData = ChallengeData()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(challengeData)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                challengeData.saveToJSON()
            }
            if phase == .active {
                for challenge in challengeData.challenges {
                    challengeData.queryDailyData(for: challenge)
                }
            }
            
        }
        
    }
}
