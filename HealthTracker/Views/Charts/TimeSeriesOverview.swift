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
                .frame(height: 100)
        }
    }
}

// ChartLayout
//umbauen, sodass die TimeSeries abhängig vom Parameter verschiedene Challenges zeigen kann
struct TimeSeriesOverviewChart: View {
    
    var challenge: Challenge
    
    var body: some View {
        
        let goal = challenge.dailyGoal
        
        Chart(StepsData.last30Days, id: \.day) {
            PointMark(
                x: .value("Tag", $0.day, unit: .day),
                y: .value("Anzahl", $0.steps))
            
            LineMark(
                x: .value("Tag", $0.day, unit: .day),
                y: .value("Anzahl", $0.steps))

            RuleMark(
                y: .value("Ziel", goal)
            )
            .foregroundStyle(Color.gray)
            .lineStyle(StrokeStyle(lineWidth: 3, dash: [8, 6] ))
            .annotation(position: .top, alignment: .leading) {
                Text("Ziel: \(goal, format: .number)")
                    .font(.body.bold())
                    .foregroundStyle(.gray)
            }
        }
    }
}

    
struct TimeSeriesOverview_Previews: PreviewProvider {
        static var previews: some View {
            TimeSeriesOverview(challenge: challenges[1])
        }
}

