//
//  TimeSeriesOverview.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import Charts
import SwiftUI

// ChartLayout
//umbauen, sodass die TimeSeries abhängig vom Parameter verschiedene Challenges zeigen kann
struct TimeSeriesOverviewChart: View {
    var body: some View {
        Chart(StepsData.last30Days, id: \.day) {
            PointMark(
                x: .value("Tag", $0.day, unit: .day),
                y: .value("Schritte", $0.steps))
            
            LineMark(
                x: .value("Tag", $0.day, unit: .day),
                y: .value("Schritte", $0.steps))
            //Datenquelle von Art der Challenge übernehmen
            let goal = StepsData.goalDaily
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
    
struct TimeSeriesOverview: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text("Letzte 30 Tage")
                    .foregroundStyle(.secondary)
                TimeSeriesOverviewChart()
                    .frame(height: 100)
            }
        }
    }
    
struct TimeSeriesOverview_Previews: PreviewProvider {
        static var previews: some View {
            TimeSeriesOverview()
        }
}

