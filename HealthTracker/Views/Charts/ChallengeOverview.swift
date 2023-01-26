//
//  ChallengeOverview.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 19.01.23.
//

import SwiftUI

struct ChallengeOverview: View {
    
    var challenge: Challenge
    
    var body: some View {
        HStack {
            VStack {
                challenge.symbole
                Text(challenge.name)
            }
            ChallengeRing(challengeProgress: challenge.progress)
        }
    }
}

struct ChallengeOverview_Previews: PreviewProvider {
    static var challenges = ChallengeData().challenges
    static var previews: some View {
        ChallengeOverview(challenge: challenges[1])
    }
}
