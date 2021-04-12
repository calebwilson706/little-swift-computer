//
//  challenge-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 12/04/2021.
//

import Foundation

class ChallengeController : ObservableObject {
    @Published var challenges = assemblyCodeInitialChallenges
    @Published var showingChallenges = false
}
