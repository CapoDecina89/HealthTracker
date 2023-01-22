//
//  ContentView.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 14.01.23.
//

import Charts
import SwiftUI

struct ContentView: View {
    
    private enum Destinations {
        case empty
        case detail
        case challenge
    }
    //@State private var selection: Destinations?
    
    
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    NavigationLink("Neue Challenge wählen"/*, value: Destinations.challenge*/) {
                        ChallengeView()
                    }
                }
                
                ForEach(challenges) { challenge in
                    Section {
                        NavigationLink {
                            DetailView(challenge: challenge)
                        } label: {
                            ChallengeOverview(challenge: challenge)
                                .frame(minHeight: 150)
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
            .listStyle(.insetGrouped)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
