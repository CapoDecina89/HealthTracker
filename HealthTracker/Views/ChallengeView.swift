//
//  ChallengeView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI

struct ChallengeView: View {
    @EnvironmentObject private var challengeData: ChallengeData
        
    var body: some View {
        List{
            Section(header: Text("Wählen Sie Ihre Challenges:")) {
                ForEach(challengeData.challenges) { challenge in
                    HStack{
                        Toggle(isOn: $challengeData.challenges[challenge.id].isActive) {
                            Text(challenge.name)
                            challenge.symbole
                                .dynamicTypeSize(.large)
                                .bold()
                            Text(challenge.description)
                        }
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
