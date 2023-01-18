//
//  DataDummy.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI

func date(year: Int, month: Int, day: Int = 1) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}
/// Data for the daily and monthly step count.
struct StepsData {
    /// Steps by day
    static let today = 6941
    static let last30Days = [
        (day: date(year: 2022, month: 5, day: 8), steps: 3000),
        (day: date(year: 2022, month: 5, day: 9), steps: 4000),
        (day: date(year: 2022, month: 5, day: 10), steps: 4584),
        (day: date(year: 2022, month: 5, day: 11), steps: 1185),
        (day: date(year: 2022, month: 5, day: 12), steps: 6941),
        (day: date(year: 2022, month: 5, day: 13), steps: 4189),
        (day: date(year: 2022, month: 5, day: 14), steps: 6416),
        (day: date(year: 2022, month: 5, day: 15), steps: 3848),
        (day: date(year: 2022, month: 5, day: 16), steps: 2458),
        (day: date(year: 2022, month: 5, day: 17), steps: 1185),
        (day: date(year: 2022, month: 5, day: 18), steps: 3848),
        (day: date(year: 2022, month: 5, day: 19), steps: 6941)
    ]
    static let last7Days = [
        (day: date(year: 2022, month: 5, day: 13), steps: 4189),
        (day: date(year: 2022, month: 5, day: 14), steps: 1416),
        (day: date(year: 2022, month: 5, day: 15), steps: 3848),
        (day: date(year: 2022, month: 5, day: 16), steps: 2458),
        (day: date(year: 2022, month: 5, day: 17), steps: 1185),
        (day: date(year: 2022, month: 5, day: 18), steps: 2848),
        (day: date(year: 2022, month: 5, day: 19), steps: 6941),
    ]
    static var last7DaysTotal: Int {
        last7Days.map { $0.steps }.reduce(0, +)
    }
    static var last30DaysTotal: Int {
        last30Days.map { $0.steps }.reduce(0, +)
    }
    static var last30DaysAverage: Double {
        Double(last30DaysTotal / last30Days.count)
    }
    static let goalDaily = 5500.0
    static let goalWeekly = goalDaily * 7
    
    static var progress = Double(StepsData.today)/StepsData.goalDaily
}
