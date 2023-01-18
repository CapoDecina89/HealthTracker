//
//  ContentView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 14.01.23.
//

import Charts
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Challenge Bewegung")
                    .font(.title)
                ChallengeRing(progressChallenge: StepsData.progress/*, last7Days: StepsData.last7DaysTotal, goalsWeekly: StepsData.goalWeekly*/)
                    .frame(height: 350.0)
            }
            Divider()
            
            }
            
            Spacer()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
