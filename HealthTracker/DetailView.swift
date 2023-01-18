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
        VStack {
            VStack {
                Text("Challenge " /* + Destination*/)
                    .font(.title)
                ChallengeRing(progressChallenge: StepsData.progress/*, last7Days: StepsData.last7DaysTotal, goalsWeekly: StepsData.goalWeekly*/)
                    .frame(height: 350.0)
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
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
