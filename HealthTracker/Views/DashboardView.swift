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
    @EnvironmentObject private var challengeData: ChallengeData
    
    ///create an Array of active challenges for use in Dashboard
    var activeChallenges: [Challenge] {
        challengeData.challenges.filter { challenge in
            (challenge.isActive)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activeChallenges) { challenge in
                    Section {
                        NavigationLink {
                            DetailView(selectedChallenge: challenge)
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
            .environmentObject(challengeData)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(ChallengeData())
    }
}
