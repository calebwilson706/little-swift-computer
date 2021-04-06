//
//  execution-speeds.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation

enum ExecutionSpeeds : Double, CaseIterable {
    case extremelySlow = 0.3,
         verySlow = 0.175,
         slow = 0.15,
         medium = 0.1,
         fast = 0.075,
         asFastAsPossible = 0.0
    
    func getDescription() -> String {
        switch self {
        case .extremelySlow:
            return "Way Too Slow"
        case .verySlow:
            return "Very Slow"
        case .slow:
            return "Slow"
        case .medium:
            return "Medium"
        case .fast:
            return "Fast"
        case .asFastAsPossible:
            return "As Fast As Possible"
        }
    }
}
