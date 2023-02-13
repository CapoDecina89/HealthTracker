//
//  Challenge.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 18.01.23.
//

import Foundation
import SwiftUI
import HealthKit

struct Challenge: Identifiable, Codable {
    var id: Int //Alternative: String {name}
    var name: String
    var description: String
    var typeIdentifier : String
    var unit: String
    //var dataType: String
    var dailyGoal: Int
    private var symboleName: String
    var symbole: Image {
        Image(systemName: symboleName)
        }
    var isActive: Bool
    var dailyData: [DailyData]?
    //als computed gestalten
    var amountToday: Double {
        dailyData?.last?.value ?? 0
    }
    
    var progress: Double {
        (amountToday ) / Double(dailyGoal)
    }
}

