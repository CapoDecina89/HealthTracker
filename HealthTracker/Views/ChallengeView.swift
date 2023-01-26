//
//  ChallengeView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI

struct ChallengeView: View {
    @EnvironmentObject private var challengeData: ChallengeData
    //@State private var multiSelection = Set<Challenge.ID>()
    
    var body: some View {
        VStack {
           //Text("Wählen Sie Ihre Challenges:")
            //    .font(.title)
              //  .bold()
            List(challengeData.challenges /*, selection: $multiSelection*/) { challenge in
                HStack{
                    Toggle(isOn: $challengeData.challenges[challenge.id].isActive) {
                        Text(challenge.name)
                        challenge.symbole
                    }
                }
            }
        }
        .navigationTitle("Challenges")
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
            .environmentObject(ChallengeData())
    }
}
