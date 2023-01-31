//
//  DetailView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI
// TimeSeries mit Lollipop Funktion erweitern
struct DetailView: View {
    ///Challenge object provided by DashboardView
    var selectedChallenge: Challenge
    
    var body: some View {
        VStack {
            VStack {
                ChallengeRing(challengeProgress: selectedChallenge.progress)
                    .frame(height: 300.0)
                Text("\(Int(selectedChallenge.amountToday)) / \(Int(selectedChallenge.dailyGoal)) \(selectedChallenge.unit)")
                    .bold()
                Text("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
            }
            Divider()
            VStack {
                TimeSeriesOverview(challenge: selectedChallenge)
                    .padding()
            }
                
            Spacer()
            .padding()
            .navigationTitle("Challenge \(selectedChallenge.name )")
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var challenges = ChallengeData().challenges
    static var previews: some View {
        DetailView(selectedChallenge: challenges[1])
    }
}
