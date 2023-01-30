//
//  DailyData.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 27.01.23.
//

import Foundation

struct DailyData: Codable, Hashable {
    var date: Date
    var value: Double
}
