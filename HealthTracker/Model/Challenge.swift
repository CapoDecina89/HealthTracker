//
//  Challenge.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 18.01.23.
//

import Foundation
import SwiftUI

struct Challenge: Identifiable, Hashable, Codable {
    var id: Int //Alternative: String {name}
    var name: String
    var unit: String
    var dailyGoal: Int
    private var symboleName: String
    var symbole: Image {
        Image(systemName: symboleName)
        }
    //als Funktionen gestalten
    var today: Double
    var progress: Double
}
