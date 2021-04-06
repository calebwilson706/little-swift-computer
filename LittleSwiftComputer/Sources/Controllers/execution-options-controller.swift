//
//  execution-options-controller.swift
//  LittleSwiftComputer
//
//  Created by Caleb Wilson on 06/04/2021.
//

import Foundation

class ExecutionOptionsController : ObservableObject {
    @Published var selectedSpeedOption : ExecutionSpeeds = .fast
}
