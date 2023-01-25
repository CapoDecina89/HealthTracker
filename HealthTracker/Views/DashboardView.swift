//
//  ContentView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 14.01.23.
//

import Charts
import SwiftUI

struct DashboardView: View {
    //Ansatz Single Source of Truth
    //@EnvironmentObject private var challengeData: ChallengeData
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(challenges) { challenge in
                    Section {
                        NavigationLink {
                            DetailView(challenge: challenge)
                        } label: {
                            ChallengeOverview(challenge: challenge)
                                .frame(minHeight: 150)
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        ChallengeView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
