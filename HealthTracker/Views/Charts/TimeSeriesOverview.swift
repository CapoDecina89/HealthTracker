//
//  TimeSeriesOverview.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import Charts
import SwiftUI

///View mit Chart und erfasstem Zeitraum
struct TimeSeriesOverview: View {
    
    var challenge: Challenge
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Letzte 30 Tage")
                .foregroundStyle(.secondary)
            TimeSeriesOverviewChart(challenge: challenge)
                .frame(height: 150)
        }
    }
}
// ChartLayout
struct TimeSeriesOverviewChart: View {
    
    var challenge: Challenge
    
    var body: some View {
        
        let goal = challenge.dailyGoal
        
        Chart(challenge.dailyData ?? [DailyData(date: Date(), value: 0)], id: \.date) {
            LineMark(
                x: .value("Tag", $0.date, unit: .day),
                y: .value("Anzahl", $0.value))
            .symbol(.circle)

            RuleMark(
                y: .value("Ziel", goal)
            )
            .foregroundStyle(Color.gray)
            .lineStyle(StrokeStyle(lineWidth: 3, dash: [8, 6] ))
        }
    }
}

struct TimeSeriesOverview_Previews: PreviewProvider {
    static var challenges = ChallengeData().challenges
    static var previews: some View {
            TimeSeriesOverview(challenge: challenges[1])
        }
}

