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
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(challengeData)
        }
        
    }
}
