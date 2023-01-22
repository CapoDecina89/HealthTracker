//
//  ChallengeView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 17.01.23.
//

import SwiftUI

struct ChallengeView: View {
    @State private var multiSelection = Set<Challenge.ID>()
    
    var body: some View {
        List(challenges, selection: $multiSelection) {challenge in
            HStack{
                Text(challenge.name)
                challenge.symbole
            }
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
