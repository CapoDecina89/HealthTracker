//
//  ContentView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 14.01.23.
//

import Charts
import SwiftUI

struct ContentView: View {
    
    private enum Destinations {
        case empty
        case steps
        case sleep
        case water
    }
    
    @State private var selection: Destinations?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section {
                    NavigationLink(value: Destinations.sleep) {
                        ChallengeRing(progressChallenge: StepsData.progress)
                            .frame(minHeight: 200)
                    }
                }
                Section {
                    NavigationLink(value: Destinations.sleep) {
                        ChallengeRing(progressChallenge: StepsData.progress)
                            .frame(minHeight: 200)
                    }
                }
                Section {
                    NavigationLink(value: Destinations.water) {
                        ChallengeRing(progressChallenge: StepsData.progress)
                            .frame(minHeight: 200)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .listStyle(.insetGrouped)
        } detail: {
            NavigationStack {
                switch selection ?? .empty {
                case .empty: Text("Select data to view.")
                case .steps: DetailView()
                case .sleep: DetailView()
                case .water: DetailView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*Text("Challenge test")
    .font(.title)
ChallengeRing(progressChallenge: StepsData.progress/*, last7Days: StepsData.last7DaysTotal, goalsWeekly: StepsData.goalWeekly*/)
    .frame(height: 350.0)
*/
