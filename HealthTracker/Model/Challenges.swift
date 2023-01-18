//
//  Challenges.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 18.01.23.
//

import Foundation

struct Challenges: Identifiable {
    let name: String
    let dailyGoal: Double
    var id: String {name}
}
