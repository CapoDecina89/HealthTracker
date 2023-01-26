//
//  ModelData.swift
//  HealthTracker
//
//  Created by Benjamin Grunow on 19.01.23.
//

import Foundation
import Combine

// Neuer Ansatz

final class ChallengeData: ObservableObject {
    //Array mit allen Daten der Challenges
    @Published var challenges: [Challenge] = load("challengeData.json")
    
    /*init(challenges: [Challenge]) {
     self.challenges = challenges
     }*/
}
    /*static*/ func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    /*
     //Überarbeiten
     func save(to filename: String) {
            
        let encoder = JSONEncoder()
        do {
            let encodedChallenges = try encoder.encode(challenges)
            try encodedChallenges.write(to: Bundle.main.bundleURL.appendingPathComponent("challengeData").appendingPathExtension(for: .json), options: .noFileProtection)
            
        } catch {
            fatalError("Couldn't save Challenges as \(filename):\n\(error)")
        }
    }*/
/*
// Alter Ansatz

//Array mit allen Daten der Challenges
var challenges: [Challenge] = load("challengeDataNew.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func save(to filename: String) {
        
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    do {
        let encodedChallenges = try encoder.encode(challenges)
        try encodedChallenges.write(to: Bundle.main.bundleURL.appendingPathComponent(filename).appendingPathExtension(for: .json), options: .noFileProtection)
        
    } catch {
        fatalError("Couldn't save Challenges as \(filename):\n\(error)")
    }
}
*/
