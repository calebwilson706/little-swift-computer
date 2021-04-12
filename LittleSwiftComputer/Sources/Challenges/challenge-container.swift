//
//  challenge-container.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import Foundation

class ChallengeContainer : ObservableObject {
    let challengeTitle : String
    let description : String
    let exampleSolution : String
    let id = UUID()
    @Published var hasBeenCompleted = false

    init(challengeTitle: String, description: String, exampleSolutionFileName: String) {
        self.challengeTitle = challengeTitle
        self.description = description
        self.exampleSolution = loadTextFile(fileName: exampleSolutionFileName)
    }
    
}



private func loadTextFile(fileName : String) -> String {
    if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
        do {
            let contents = try String(contentsOfFile: filePath)
            return contents
        } catch {
            return "Cannot Load Solution"
        }
    }
    
    return "No Solution Found"
}
