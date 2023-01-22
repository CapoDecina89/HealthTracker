//
//  DetailView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI
// Anzeige von gewählter Challenge abhängig machen
// TimeSeries mit Lollipop Funktion erweitern
struct DetailView: View {
    var challenge: Challenge
    var body: some View {
        TabView {
            //ForEach einfügen und Datenquelle für Challenges anlegen
            VStack {
                VStack {
                    Text("Challenge \(challenge.name )")
                        .font(.title)
                    ChallengeRing(challengeProgress: challenge.progress)
                        .frame(height: 300.0)
                    Text("\(Int(challenge.today)) / \(Int(challenge.dailyGoal)) \(challenge.unit)")
                        .bold()
                    Text("\(Date.now.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                }
                Divider()
                VStack {
                    TimeSeriesOverview()
                        .padding()
                }
                
                Spacer()
                .padding()
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(challenge: challenges[1])
    }
}
