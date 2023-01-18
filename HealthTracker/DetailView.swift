//
//  DetailView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI
// Anzeige von gewählter Challenge abhängig machen
struct DetailView: View {
    var body: some View {
        TabView {
            //ForEach einfügen und Datenquelle für Challenges anlegen
            VStack {
                VStack {
                    Text("Challenge " /* + Destination*/)
                        .font(.title)
                    ChallengeRing(progressChallenge: StepsData.progress)
                        .frame(height: 300.0)
                    Text("\(Int(StepsData.today)) / \(Int(StepsData.goalDaily)) Schritte")
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
        DetailView()
    }
}
